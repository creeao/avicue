//
//  BottomTextFieledButton.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/12/2022.
//

import UIKit

protocol BottomTextFieledButtonDelegate: AnyObject {
    func tapButton(text: String)
}

final class BottomTextFieledButton: UIView {
    // MARK: External properties
    weak var delegate: BottomTextFieledButtonDelegate?
    
    // MARK: Private properties
    private let separatorView = UIView()
    private let textFieldButton = TextFieldButton()
    
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
extension BottomTextFieledButton {
    func setup(placeholder: String = "Type something...", image: UIImage? = Image.send) {
        textFieldButton.setup(placeholder: placeholder, buttonImage: image)
    }
    
    func getText() -> String? {
        return textFieldButton.getText()
    }
    
    func setTextField(text: String) {
        textFieldButton.setTextField(text: text)
    }
}

extension BottomTextFieledButton: TextFieldButtonDelegate {
    func tapButton(text: String) {
        delegate?.tapButton(text: text)
    }
}

// MARK: Private methods
extension BottomTextFieledButton {
    func setupView() {
        setupSeparator()
        setupTextFieldButton()
    }
    
    func setupSeparator() {
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Color.gray.withFrailAlpha
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.borderWidth)
        ])
    }
    
    func setupTextFieldButton() {
        addSubview(textFieldButton)
        textFieldButton.translatesAutoresizingMaskIntoConstraints = false
        textFieldButton.delegate = self
        
        NSLayoutConstraint.activate([
            textFieldButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Margin.normal.top),
            textFieldButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            textFieldButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.normal.trailing),
            textFieldButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.normal.bottom),
            textFieldButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
