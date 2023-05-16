//
//  PillButton.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class PillButton: UIButton {
    // MARK: External properties
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: .longAnimationTime) { [weak self] in
                self?.backgroundColor = (self?.isHighlighted).isTrue ? Color.background.withThinAlpha : Color.background
            }
        }
    }
    
    // MARK: Private properties
    private let icon = UIImageView()
    private let label = UILabel()
    private var padding = Margin.normal.space
}

// MARK: External methods
extension PillButton {
    func setup(with text: String, and image: UIImage? = nil) {
        icon.image = image
        label.text = text
        
        image.isNil ? setupWithoutImage() : setupWithImage()
    }
    
    func setPadding(_ value: CGFloat = Margin.normal.space) {
        padding = value
    }
    
    func setTitle(_ text: String) {
        label.text = text
    }
}

// MARK: Private methods
private extension PillButton {
    func setupWithoutImage() {
        setupBackground()
        setupLabelWithoutImage()
    }
    
    func setupWithImage() {
        setupPadding()
        setupBackground()
        setupImage()
        setupLabel()
    }
    
    func setupPadding() {
        let width = UIScreen.main.bounds.size.width
        let paddingElement = (width - (56 + 99 + 76) - 32 - 20 - 20) / 6
        padding = !paddingElement.isZero ? paddingElement : Margin.medium.space
    }
    
    func setupBackground() {
        backgroundColor = Color.background
        layer.cornerRadius = Constants.smallerCornerRadius
    }

    func setupImage() {
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.small.bottom),
            icon.heightAnchor.constraint(equalToConstant: 18),
            icon.widthAnchor.constraint(equalToConstant: 18)
        ])
    }

    func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.smallMedium
        label.textColor = Color.gray

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Margin.small.leading),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
    
    func setupLabelWithoutImage() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.smallMedium
        label.textColor = Color.gray
        layer.cornerRadius = Constants.cornerRadius

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: Margin.tiny.top),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.tiny.bottom)
        ])
    }
}
