//
//  TextFieldTitleLogoButtonCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//

import UIKit

protocol TextFieldTitleLogoButtonCellDelegate: AnyObject {
    func tapView()
}

class TextFieldTitleLogoButtonCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: TextFieldTitleLogoButtonCellDelegate?
    
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let logoView = UIImageView()
    private let textField = TextField()
    private let textView = UITextView()
    private let button = Button()
    
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
extension TextFieldTitleLogoButtonCell {
    func setup(with title: String, and placeholder: String) {
        titleLabel.text = title
        textField.setupPlaceholder(placeholder, aligment: .left, height: Constants.Size.textField)
    }
    
    func select(with model: CompanyModel) {
        id = model.id
        logoView.getImage(from: model.logo)
        textField.text = model.name
    }
    
    func select(with model: GroupModel) {
        id = model.id
        logoView.getImage(from: model.logo)
        textField.text = model.name
    }
}

// MARK: Events
private extension TextFieldTitleLogoButtonCell {
    @objc func tapView() {
        delegate?.tapView()
    }
}
    
// MARK: Private methods
private extension TextFieldTitleLogoButtonCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupLogoView()
        setupTextField()
        setupButton()
        setupGesture()
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
    
    func setupLogoView() {
        containerView.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = Image.empty
        logoView.layer.masksToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.layer.borderWidth = Constants.borderWidth
        logoView.layer.borderColor = Color.gray.withThinAlpha.cgColor
        logoView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            logoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            logoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            logoView.heightAnchor.constraint(equalToConstant: Constants.Size.textField),
            logoView.widthAnchor.constraint(equalToConstant: Constants.Size.textField),
        ])
    }
    
    func setupTextField() {
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            textField.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: Margin.medium.leading),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func setupButton() {
        containerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setup(for: .filledImage, and: Image.arrowRight)
        button.addTarget(self, action: #selector(tapView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Margin.medium.leading),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.Size.textField),
            button.widthAnchor.constraint(equalToConstant: Constants.Size.textField),
        ])
    }
    
    func setupGesture() {
        let gestureView = UIView()
        containerView.addSubview(gestureView)
        gestureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gestureView.topAnchor.constraint(equalTo: containerView.topAnchor),
            gestureView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gestureView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gestureView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapView))
        gestureView.addGestureRecognizer(action)
    }
}
