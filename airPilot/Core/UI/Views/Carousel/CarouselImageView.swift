//
//  CarouselView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol CarouselImageViewDelegate: AnyObject {
    func swipeImage(to element: Int)
}

class CarouselImageView: UIView {
    // MARK: External properties
    weak var delegate: CarouselImageViewDelegate?
    
    // MARK: Private properties
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout())
    private var images: [String] = []
    private var timer: Timer?
    private var selectedIndex: Int = 0
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }

    deinit {
        timer?.invalidate()
    }
}

// MARK: External methods
extension CarouselImageView {
    func setup(images: [String]) {
        self.images = images
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension CarouselImageView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.isNotEmpty ? images.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        if images.isNotEmpty {
            imageView.getImage(from: images[indexPath.row])
        } else {
            imageView.image = Image.empty
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: cell.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
        ])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.swipeImage(to: indexPath.row)
    }
}

// MARK: Private methods
private extension CarouselImageView {
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 230),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func scheduleTimerIfNeeded() {
        guard images.count > 1 else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 5.0,
            repeats: true,
            block: { [weak self] _ in
                self?.selectedIndex != self?.images.count ? self?.selectNext() : self?.selectItem(at: 0)
            }
        )
    }
    
    func selectNext() {
        selectItem(at: selectedIndex + 1)
    }
    
    func selectItem(at index: Int) {
        let index = images.count > index ? index : 0
        guard selectedIndex != index else { return }
        selectedIndex = index
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}
