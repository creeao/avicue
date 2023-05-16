//
//  CarouselImageCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class CarouselImageCell: CustomTableViewCell {
    // MARK: Private properties
    private let carouselView = CarouselImageView()
    private let carouselDotsView = CarouselDotsView()

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
extension CarouselImageCell {
    func setup(with images: [String]?) {
        guard let images = images else { return }
        carouselView.setup(images: images)
        carouselDotsView.setup(elements: images.count)
    }
}

// MARK: CarouselImageViewDelegate
extension CarouselImageCell: CarouselImageViewDelegate {
    func swipeImage(to element: Int) {
        carouselDotsView.select(element: element)
    }
}

// MARK: Private methods
private extension CarouselImageCell {
    func setupView() {
        setupContainerView()
        setupCarouselView()
        setupCarouselDotsView()
    }
    
    func setupCarouselView() {
        containerView.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.delegate = self
        carouselView.addShadow()
        
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: containerView.topAnchor),
            carouselView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func setupCarouselDotsView() {
        containerView.addSubview(carouselDotsView)
        carouselDotsView.translatesAutoresizingMaskIntoConstraints = false
        carouselDotsView.addShadow()
        
        NSLayoutConstraint.activate([
            carouselDotsView.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: Margin.mini.top),
            carouselDotsView.centerXAnchor.constraint(equalTo: carouselView.centerXAnchor),
            carouselDotsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
