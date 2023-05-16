//
//  MessageCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol MessageCellDelegate: AnyObject {
    func tapUser(userUuid: String)
}

final class MessageCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: MessageCellDelegate?
    
    // MARK: Private properties
    private let avatarImageView = UIImageView()
    private let labelsContainer = UIStackView()
    private let messageLabel = UILabel()
//    private let nameLabel = UILabel()
//    private let dateLabel = UILabel()
    private var userUuid: String = String.empty
    
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
extension MessageCell {
    func setup(with message: MessageModel) {
        userUuid = (message.createdBy?.uuid).orEmpty
        
        if message.createdBy?.uuid == Globals.userUuid {
            setupUserSetup()
        } else {
            setupOtherSetup()
        }
        
        avatarImageView.getImage(from: message.createdBy?.avatar)
        messageLabel.text = message.text
    }
}

// MARK: Events
private extension MessageCell {
    @objc func tapUser() {
        delegate?.tapUser(userUuid: userUuid)
    }
}
    
// MARK: Private methods
private extension MessageCell {
    func setupView() {
        setupContainerView()
        setupLogoImageView()
        setupLabelsContainerView()
        setupMessageLabel()
        
        labelsContainer.layer.cornerRadius = Constants.cornerRadius
        labelsContainer.addShadow()
        
        labelsContainer.layoutMargins = Insets.setup(margin: Margin.regular.space)
        labelsContainer.isLayoutMarginsRelativeArrangement = true
    }
    
    func setupUserSetup() {
        messageLabel.textColor = Color.white
        labelsContainer.backgroundColor = Color.black
        
        NSLayoutConstraint.activate([
            labelsContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            labelsContainer.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            labelsContainer.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: Margin.regular.trailing),
            labelsContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: labelsContainer.centerYAnchor)
        ])
    }
    
    func setupOtherSetup() {
        messageLabel.textColor = Color.black
        labelsContainer.backgroundColor = Color.white
        
        NSLayoutConstraint.activate([
            labelsContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            labelsContainer.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Margin.regular.leading),
            labelsContainer.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: Margin.normal.trailing),
            labelsContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: labelsContainer.centerYAnchor)
        ])
    }
    
    func setupLogoImageView() {
        containerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        avatarImageView.addShadow()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapUser))
        avatarImageView.addGestureRecognizer(gesture)
        avatarImageView.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLabelsContainerView() {
        containerView.addSubview(labelsContainer)
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupMessageLabel() {
        labelsContainer.addArrangedSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = Font.largeRegular
        messageLabel.numberOfLines = 0
    }
}
