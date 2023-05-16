//
//  FavouriteButton.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class FavouriteButton: UIButton {
    // MARK: Private properties
    private let heartImageView = UIImageView()
    private var isFavourite: Bool = false

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
extension FavouriteButton {
    func setFavourite() {
        isFavourite = true
        heartImageView.image = Image.heartActive
        heartImageView.addShadow(with: Color.salmon.withHardAlpha, and: 10)
    }

    func removeFavourite() {
        isFavourite = false
        heartImageView.image = Image.heart
        heartImageView.addShadow(with: Color.shadow.withThinAlpha, and: 10)
    }

    func checkState() -> Bool {
        return isFavourite
    }
}

// MARK: Private methods
private extension FavouriteButton {
    func setupView() {
        setupBackground()
        setupStarImageView()
    }

    func setupBackground() {
        backgroundColor = Color.white.withRegularAlpha
        layer.cornerRadius = 10
        addShadow(with: Color.shadow, and: 10)
    }

    func setupStarImageView() {
        addSubview(heartImageView)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.image = Image.heart
        heartImageView.addShadow(with: Color.shadow.withThinAlpha, and: 10)
        heartImageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            heartImageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            heartImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.little.bottom),
            heartImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            heartImageView.heightAnchor.constraint(equalToConstant: 21),
            heartImageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
}
