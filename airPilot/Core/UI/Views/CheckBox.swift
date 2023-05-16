//
//  CheckBox.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

final class CheckBox: UIButton {
    // MARK: External properties
    private var checkboxState: Bool = false
    private let checkboxImage = UIImageView()
    
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
extension CheckBox {
    func select() {
        checkboxState = true
        checkboxImage.image = Image.checkboxSelected
    }
    
    func unselect() {
        checkboxState = false
        checkboxImage.image = Image.checkboxUnselected
    }
    
    func isSelected() -> Bool {
        return checkboxState
    }
}

// MARK: Private methods
private extension CheckBox {
    func setupView() {
        addSubview(checkboxImage)
        checkboxImage.image = Image.checkboxUnselected
        checkboxImage.translatesAutoresizingMaskIntoConstraints = false
        checkboxImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            checkboxImage.topAnchor.constraint(equalTo: topAnchor),
            checkboxImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkboxImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkboxImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
