//
//  TextFieldButton.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol TextFieldButtonDelegate: AnyObject {
    func tapButton(text: String)
}

final class TextFieldButton: UIView {
    weak var delegate: TextFieldButtonDelegate?
    
    // MARK: Private properties
    private let textField = TextField()
    private var button = Button()
    
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
extension TextFieldButton {
    func setup(placeholder: String, buttonImage: UIImage?) {
        textField.setupPlaceholder(placeholder, aligment: .left)
        button.setup(for: .filledImage, and: buttonImage)
    }
    
    func getText() -> String? {
        return textField.text
    }
    
    func setTextField(text: String) {
        textField.text = text
    }
}

// MARK: Events
private extension TextFieldButton {
    @objc func tapButton() {
        delegate?.tapButton(text: textField.text.orEmpty)
    }
}

// MARK: Private methods
private extension TextFieldButton {
    func setupView() {
        setupTextField()
        setupButton()
    }
    
    func setupTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Margin.medium.leading),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}
