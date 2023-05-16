//
//  RatingView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class RatingView: UIView {
    // MARK: Private properties
    private let stackView = UIStackView()
    private let starImageView = UIImageView()
    private let ratingLabel = UILabel()
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension RatingView {
    func setup(rating: Decimal?) {
        ratingLabel.text = rating.orZero.description
    }
}

// MARK: Private methods
private extension RatingView {
    func setupView() {
        setupStackView()
        setupStarImageView()
        setupRatingLabel()
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Margin.mini.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupStarImageView() {
        stackView.addArrangedSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.image = Image.star?.withTintColor(Color.yellow)
        
        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 15),
            starImageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func setupRatingLabel() {
        stackView.addArrangedSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textColor = Color.yellow
        ratingLabel.font = Font.normalSemiBold
    }
}
