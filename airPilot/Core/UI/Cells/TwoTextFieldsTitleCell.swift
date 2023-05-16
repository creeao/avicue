//
//  TwoTextFieldsTitleCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/01/2023.
//

import UIKit

class TwoTextFieldsTitleCell: CustomTableViewCell {
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let smallTextField = TextField()
    private let bigTextField = TextField()
    
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
extension TwoTextFieldsTitleCell {
    func setup(with title: String, _ smallPlaceholder: String, _ bigPlaceholder: String) {
        titleLabel.text = title
        smallTextField.setupPlaceholder(smallPlaceholder, height: Constants.Size.textField)
        bigTextField.setupPlaceholder(bigPlaceholder, aligment: .left, height: Constants.Size.textField)
    }
    
    func getSmallText() -> String? {
        return smallTextField.text
    }
    
    func getBigText() -> String? {
        return bigTextField.text
    }
}
    
// MARK: Private methods
private extension TwoTextFieldsTitleCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupSmallTextField()
        setupBigTextField()
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
    
    func setupSmallTextField() {
        containerView.addSubview(smallTextField)
        smallTextField.translatesAutoresizingMaskIntoConstraints = false
        smallTextField.setupMaxChars(3)
        
        NSLayoutConstraint.activate([
            smallTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            smallTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            smallTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            smallTextField.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupBigTextField() {
        containerView.addSubview(bigTextField)
        bigTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            bigTextField.leadingAnchor.constraint(equalTo: smallTextField.trailingAnchor, constant: Margin.small.leading),
            bigTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bigTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
