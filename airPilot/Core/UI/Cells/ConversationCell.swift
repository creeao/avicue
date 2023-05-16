//
//  ConversationCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

final class ConversationCell: TableViewCell {
    // MARK: Private properties
    private let avatarImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let conversationLabel = UILabel()
    private let dateLabel = UILabel()
    
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
extension ConversationCell {
    func setup(with conversation: ConversationModel) {
        id = conversation.id
        let avatar = conversation.avatar ?? conversation.users?.first(where: { $0.uuid != Globals.userUuid })?.avatar
        let name = conversation.name ?? conversation.users?.first(where: { $0.uuid != Globals.userUuid })?.getName()
        
        avatarImageView.getImage(from: avatar)
        nameLabel.text = name
        conversationLabel.text = conversation.messages?.last?.text
        dateLabel.text = conversation.messages?.last?.createdDate
    }
}
    
// MARK: Private methods
private extension ConversationCell {
    func setupView() {
        setupLogoImageView()
        setupLabelsContainerView()
    }
    
    func setupLogoImageView() {
        containerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.little.top),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.little.leading),
            avatarImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.little.bottom),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Size.smallLogo),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Size.smallLogo)
        ])
    }
    
    func setupLabelsContainerView() {
        containerView.addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsContainerView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Margin.small.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.small.trailing),
            labelsContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        setupNameLabel()
        setupConversationLabel()
        setupConversationDateLabel()
    }
    
    func setupNameLabel() {
        labelsContainerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Font.normalSemiBold
        nameLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
        ])
    }
    
    func setupConversationLabel() {
        labelsContainerView.addSubview(conversationLabel)
        conversationLabel.translatesAutoresizingMaskIntoConstraints = false
        conversationLabel.font = Font.smallRegular
        conversationLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            conversationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.tiny.top),
            conversationLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            conversationLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            conversationLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor),
        ])
    }
    
    func setupConversationDateLabel() {
        labelsContainerView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = Font.miniMedium
        dateLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: conversationLabel.trailingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: conversationLabel.centerYAnchor)
        ])
    }
    
//    func setupDate(with startDate: Date?, and endDate: Date?) -> String {
//        return "09.2018 - 04.2022"
//    }
}
