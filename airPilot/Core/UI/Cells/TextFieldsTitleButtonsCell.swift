//
//  TextFieldsTitleButtonCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 26/01/2023.
//

import UIKit

class TextFieldsTitleButtonsCell: CustomTableViewCell {
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let addButton = Button()
    private let removeButton = Button()
    
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
extension TextFieldsTitleButtonsCell {
    func setup(with title: String) {
        titleLabel.text = title
    }
    
    func getArray() -> [String]? {
        var values: [String] = []
        stackView.arrangedSubviews.forEach { textField in
            if let text = (textField as? TextField)?.text {
                values.append(text)
            }
        }
        return values
    }
}

// MARK: Events
private extension TextFieldsTitleButtonsCell {
    @objc func tapPlus() {
        addTextField()
    }
    
    @objc func tapMinus() {
        removeTextField()
    }
}
    
// MARK: Private methods
private extension TextFieldsTitleButtonsCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupScrollView()
        setupStackView()
        setupAddButton()
        setupRemoveButton()
        
        addTextField()
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
    
    func setupScrollView() {
        containerView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: Constants.Size.textField)
        ])
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Margin.small.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func addTextField() {
        let textField = TextField()
        stackView.addArrangedSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setupPlaceholder("JFK")
        textField.set(width: 80)
        textField.setupMaxChars(3)
    }
    
    func removeTextField() {
        stackView.arrangedSubviews.last?.removeFromSuperview()
    }
    
    func setupAddButton() {
        scrollView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(tapPlus), for: .touchUpInside)
        addButton.setup(for: .filledImage, and: Image.plusButton)
        addButton.set(width: Constants.Size.textField)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Margin.medium.leading),
            addButton.heightAnchor.constraint(equalToConstant: Constants.Size.textField)
        ])
    }
    
    func setupRemoveButton() {
        scrollView.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.addTarget(self, action: #selector(tapMinus), for: .touchUpInside)
        removeButton.setup(for: .filledImage, and: Image.minusButton)
        removeButton.set(width: Constants.Size.textField)
        
        NSLayoutConstraint.activate([
            removeButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            removeButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            removeButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: Margin.medium.leading),
            removeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            removeButton.heightAnchor.constraint(equalToConstant: Constants.Size.textField),
        ])
    }
}
