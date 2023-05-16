//
//  TextFieldTitleCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//

import UIKit

class TextFieldTitleCell: CustomTableViewCell {
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let textField = TextField()
    private let textView = UITextView()
    
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
extension TextFieldTitleCell {
    func setup(with title: String, and placeholder: String) {
        titleLabel.text = title
        textField.setupPlaceholder(placeholder, aligment: .left, height: Constants.Size.textField)
    }
    
    func getText() -> String? {
        return textField.text
    }
    
    func setText(_ text: String?) {
        textField.text = text
    }
}
    
// MARK: Private methods
private extension TextFieldTitleCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupTextField()
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.miniMedium
        titleLabel.textColor = Color.gray.withHardAlpha
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func setupTextField() {
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
