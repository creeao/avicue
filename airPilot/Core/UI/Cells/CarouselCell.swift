//
//  CarouselCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class CarouselCell: CustomTableViewCell {
    // MARK: Private properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let carouselDotsView = CarouselDotsView()
    private var images: [String] = []
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension CarouselCell {
    func setup(with images: [String], and frame: CGRect) {
        self.images = images
        setupElements(frame: frame)
    }
}

// MARK: UIScrollViewDelegate
extension CarouselCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
    }
}

// MARK: Private methods
private extension CarouselCell {
    func setupView() {
        setupContainerView()
        setupScrollView()
        setupStackView()
        setupCarouselDotsView()
    }
    
    func setupScrollView() {
        containerView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        
//        scrollView.frame = .init(x: 0, y: 0, width: 300, height: 250)
        
        scrollView.addShadow()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Margin.normal.space
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    func setupCarouselDotsView() {
        containerView.addSubview(carouselDotsView)
        carouselDotsView.translatesAutoresizingMaskIntoConstraints = false
        carouselDotsView.addShadow()

        NSLayoutConstraint.activate([
            carouselDotsView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Margin.mini.top),
            carouselDotsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            carouselDotsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupElements(frame: CGRect) {
//        var width: CGFloat = 0
//        let padding: CGFloat = Margin.normal.space

//        let viewWidth = scrollView.frame.size.width - 2 * padding
//        let viewHeight = scrollView.frame.size.height - 2 * padding
        
        images.forEach {
            let imageView = UIImageView()
            imageView.getImage(from: $0)
            stackView.addArrangedSubview(imageView)
            
            
//            let frame = CGRect(x: width + padding, y: padding, width: viewWidth, height: viewHeight)
//            let imageView = UIImageView(frame: frame)
//            imageView.backgroundColor = .red
////            print($0)
//            imageView.contentMode = .scaleToFill
//            imageView.getImage(from: $0)
            

//            imageView.sizeThatFits(CGSize(width: 300, height: 250))
//            imageView.frame = CGRect(
//                x: width + padding,
//                y: padding,
//                width: viewWidth,
//                height: viewHeight)

//            scrollView.addSubview(imageView)
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 250),
                imageView.heightAnchor.constraint(equalToConstant: 300)
            ])
//
//            width = frame.origin.x + viewWidth + padding + viewWidth + viewWidth + viewWidth + viewWidth + viewWidth + viewWidth
        }
        
//        scrollView.contentSize = CGSize(width: 1000, height: 250)
    }
}

