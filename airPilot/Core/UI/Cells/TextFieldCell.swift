//
//  TextFieldCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 02/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class TextFieldCell: CustomTableViewCell {
    // MARK: Private properties
    private let textField = TextField()
    
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
extension TextFieldCell {
    func setup(with placeholder: String) {
        textField.placeholder = placeholder
    }
}
    
// MARK: Private methods
private extension TextFieldCell {
    func setupView() {
        setupContainerView()
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
