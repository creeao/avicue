//
//  MenuElementCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//

import UIKit

enum MenuElementType {
    case jobOffersPanel
    case shopOffersPanel
    case calendar
    case createCompany
    case createGroup
    case settings
}

protocol MenuElementCellDelegate: AnyObject {
    func tapElement(_ type: MenuElementType)
}

class MenuElementCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: MenuElementCellDelegate?
    
    // MARK: Private properties
    private let button = Button()
    private let titleLabel = UILabel()
    private var elementType: MenuElementType = .settings
    
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
extension MenuElementCell {
    func setup(with image: UIImage?, and text: String, type: MenuElementType) {
        button.setup(for: .filledImage, and: image)
        titleLabel.text = text
        elementType = type
    }
}

// MARK: Events
private extension MenuElementCell {
    @objc func tapElement() {
        delegate?.tapElement(elementType)
    }
}
    
// MARK: Private methods
private extension MenuElementCell {
    func setupView() {
        setupContainerView()
        setupButton()
        setupTitleLabel()
        setupGesture()
    }
    
    func setupButton() {
        containerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.set(width: 40, height: 40)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.little.leading),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.bigMedium
        titleLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: Margin.small.leading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.small.trailing),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func setupGesture() {
        button.addAction(self, #selector(tapElement))
        containerView.addGesture(self, #selector(tapElement))
    }
}
