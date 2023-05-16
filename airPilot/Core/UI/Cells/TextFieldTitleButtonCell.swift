//
//  TextFieldTitleButtonCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//

import UIKit

enum TextFieldTitleButtonType {
    case calendar
    case arrow
    case text(String)
}

protocol TextFieldTitleButtonCellDelegate: AnyObject {
    func tapTextFieldTitleButtonCell()
}

class TextFieldTitleButtonCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: TextFieldTitleButtonCellDelegate?
    
    // MARK: Private properties
    private let titleLabel = UILabel()
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
extension TextFieldTitleButtonCell {
    func setup(with title: String, and placeholder: String, type: TextFieldTitleButtonType = .arrow, buttonWidth: CGFloat = 0, withGesture: Bool = false) {
        titleLabel.text = title
        textField.setupPlaceholder(placeholder, aligment: .left, height: Constants.Size.textField)
        switch type {
        case .arrow:
            button.setup(for: .filledImage, and: Image.arrowRight)
            setupImageSize()
        case .calendar:
            button.setup(for: .filledImage, and: Image.calendar)
            setupImageSize()
        case .text(let title):
            button.setup(for: .selector, with: title)
            button.set(width: buttonWidth)
        }
        
        if withGesture {
            setupGesture()
        }
    }
    
    func select(with category: Category) {
        id = category.id
        textField.text = category.name
    }
    
    func getText() -> String? {
        return textField.text
    }
    
    func setText(_ text: String?) {
        textField.text = text
    }
}

// MARK: Events
private extension TextFieldTitleButtonCell {
    @objc func tapTextFieldTitleButtonCell() {
        delegate?.tapTextFieldTitleButtonCell()
    }
}
    
// MARK: Private methods
private extension TextFieldTitleButtonCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupTextField()
        setupButton()
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
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapTextFieldTitleButtonCell), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Margin.medium.leading),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.Size.textField),
        ])
    }
    
    func setupImageSize() {
        button.set(width: Constants.Size.textField)
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
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapTextFieldTitleButtonCell))
        gestureView.addGestureRecognizer(action)
    }
}
