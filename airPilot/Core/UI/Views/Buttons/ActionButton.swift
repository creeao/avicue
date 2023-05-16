//
//  ActionButton.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    // MARK: External properties
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: .longAnimationTime) { [weak self] in
                self?.image.image = (self?.isHighlighted).isTrue ? self?.activeImage : self?.inactiveImage
            }
        }
    }
    
    // MARK: Private properties
    private let image = UIImageView()
    private var inactiveImage: UIImage?
    private var activeImage: UIImage?
    private var isActive: Bool = false

    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        image.image = isActive ? activeImage : inactiveImage
    }
}

// MARK: External methods
extension ActionButton {
    func setActive() {
        isActive = true
        image.image = activeImage
    }

    func setInactive() {
        isActive = false
        image.image = inactiveImage
    }

    func checkState() -> Bool {
        return isActive
    }
    
    func setup(inactiveImage: UIImage?, activeImage: UIImage?) {
        self.inactiveImage = inactiveImage
        self.activeImage = activeImage
    }
}

// MARK: Private methods
private extension ActionButton {
    func setupView() {
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        inactiveImage = Image.likeFilled
        image.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
