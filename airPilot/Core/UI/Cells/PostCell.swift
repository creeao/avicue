//
//  PostCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func tapPostAuthor(userUuid: String)
    func tapShareButton()
    func tapLikeButton(postId: Int)
}

class PostCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: PostCellDelegate?
    
    // MARK: Private properties
    private var model: PostModel? = nil
    
    private let userActivityContainer = UIView()
    private let userActivityAvatar = UIImageView()
    private let userActivityLabel = UILabel()
    private let userActivityDescriptionLabel = UILabel()
    private let messageContainer = UIView()
    private let authorLabel = UILabel()
    private let messageLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let actionsContainer = UIView()
    private let avatarImageView = UIImageView()
    private let messageButton = ActionButton()
    private let likeButton = ActionButton()
    
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
extension PostCell {
    func setup(with post: PostModel, and inProfile: Bool, withActivity: Bool) {
        model = post
        authorLabel.text = post.createdBy?.getName()
        messageLabel.text = post.text
        dateLabel.text = setupDate(post.createdDate)
        avatarImageView.getImage(from: post.createdBy?.avatar)
        post.likedBy.contains(Globals.userUuid) ? likeButton.setActive() : likeButton.setInactive()
        
        if inProfile {
            setupForProfile()
        }
        
        if withActivity {
            setupUserActivityContainer(user: post.likedBy?.first)
        } else {
            setupMessageConstraint()
        }
    }
    
    func getModel() -> PostModel? {
        return model
    }
}

// MARK: Events
private extension PostCell {
    @objc func tapPostAuthor() {
        delegate?.tapPostAuthor(userUuid: (model?.createdBy?.uuid).orEmpty)
    }
    
    @objc func tapShareButton() {
        delegate?.tapShareButton()
    }
    
    @objc func tapLikeButton() {
        likeButton.checkState() ? likeButton.setInactive() : likeButton.setActive()
        delegate?.tapLikeButton(postId: (model?.id).orZero)
    }
}

// MARK: Private methods
private extension PostCell {
    func setupView() {
        setupContainerView()
        setupMessageContainer()
        setupActionsContainer()
    }
    
    func setupUserActivityContainer(user: UserModel?) {
        guard let user else {
            setupMessageConstraint()
            return
        }
        
        containerView.addSubview(userActivityContainer)
        userActivityContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userActivityContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.mini.top),
            userActivityContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            messageContainer.topAnchor.constraint(equalTo: userActivityContainer.bottomAnchor, constant: Margin.small.top)
        ])
        
        setupUserActivityAvatar(avatar: user.avatar)
        setupUserActivityLabel(text: user.getName())
        setupUserActivityDescriptionLabel(text: " liked this post.")
    }
    
    func setupUserActivityAvatar(avatar: String?) {
        userActivityContainer.addSubview(userActivityAvatar)
        userActivityAvatar.translatesAutoresizingMaskIntoConstraints = false
        userActivityAvatar.layer.masksToBounds = true
        userActivityAvatar.layer.cornerRadius = Constants.smallerCornerRadius
        userActivityAvatar.getImage(from: avatar)
        userActivityAvatar.set(width: 26, height: 26)
        userActivityAvatar.addShadow()
        
        NSLayoutConstraint.activate([
            userActivityAvatar.topAnchor.constraint(equalTo: userActivityContainer.topAnchor),
            userActivityAvatar.leadingAnchor.constraint(equalTo: userActivityContainer.leadingAnchor),
            userActivityAvatar.bottomAnchor.constraint(equalTo: userActivityContainer.bottomAnchor)
        ])
    }
    
    func setupUserActivityLabel(text: String) {
        userActivityContainer.addSubview(userActivityLabel)
        userActivityLabel.translatesAutoresizingMaskIntoConstraints = false
        userActivityLabel.text = text
        userActivityLabel.font = Font.normalBold
        userActivityLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            userActivityLabel.centerYAnchor.constraint(equalTo: userActivityAvatar.centerYAnchor),
            userActivityLabel.leadingAnchor.constraint(equalTo: userActivityAvatar.trailingAnchor, constant: Margin.small.leading)
        ])
    }
    
    func setupUserActivityDescriptionLabel(text: String) {
        userActivityContainer.addSubview(userActivityDescriptionLabel)
        userActivityDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        userActivityDescriptionLabel.text = text
        userActivityDescriptionLabel.font = Font.normalMedium
        userActivityDescriptionLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            userActivityDescriptionLabel.centerYAnchor.constraint(equalTo: userActivityLabel.centerYAnchor),
            userActivityDescriptionLabel.leadingAnchor.constraint(equalTo: userActivityLabel.trailingAnchor),
            userActivityDescriptionLabel.trailingAnchor.constraint(equalTo: userActivityContainer.trailingAnchor)
        ])
    }
    
    func setupMessageConstraint() {
        NSLayoutConstraint.activate([
            messageContainer.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    func setupMessageContainer() {
        containerView.addSubview(messageContainer)
        messageContainer.translatesAutoresizingMaskIntoConstraints = false
        messageContainer.layer.cornerRadius = Constants.cornerRadius
        messageContainer.backgroundColor = Color.white
        messageContainer.addShadow()
        
        NSLayoutConstraint.activate([
            messageContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            messageContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        setupAuthorLabel()
        setupMessageLabel()
        setupDateLabel()
    }
    
    func setupAuthorLabel() {
        messageContainer.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = Font.bigSemiBold
        authorLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: messageContainer.topAnchor, constant: Margin.normal.top),
            authorLabel.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor, constant: Margin.normal.leading),
            authorLabel.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor),
        ])
    }
    
    func setupMessageLabel() {
        messageContainer.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = Font.largeRegular
        messageLabel.textColor = Color.black
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Margin.small.top),
            messageLabel.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor, constant: Margin.normal.leading),
            messageLabel.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor, constant: Margin.normal.trailing),
        ])
    }
    
    func setupDateLabel() {
        messageContainer.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = Font.miniMedium
        dateLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Margin.medium.top),
            dateLabel.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor, constant: Margin.normal.leading),
            dateLabel.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor, constant: Margin.normal.trailing),
            dateLabel.bottomAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: Margin.normal.bottom),
        ])
    }
    
    func setupActionsContainer() {
        containerView.addSubview(actionsContainer)
        actionsContainer.translatesAutoresizingMaskIntoConstraints = false
        actionsContainer.layer.cornerRadius = Constants.cornerRadius
        actionsContainer.backgroundColor = Color.white.withLightAlpha
        actionsContainer.addShadow()
        
        NSLayoutConstraint.activate([
            actionsContainer.centerYAnchor.constraint(equalTo: messageContainer.centerYAnchor),
            actionsContainer.leadingAnchor.constraint(equalTo: messageContainer.trailingAnchor, constant: Margin.regular.leading),
            actionsContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionsContainer.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        setupAvatarImageView()
        setupShareButton()
        setupLikeButton()
    }
    
    func setupAvatarImageView() {
        actionsContainer.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapPostAuthor))
        avatarImageView.addGestureRecognizer(action)
        avatarImageView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: actionsContainer.topAnchor, constant: Margin.mini.top),
            avatarImageView.leadingAnchor.constraint(equalTo: actionsContainer.leadingAnchor, constant: Margin.mini.leading),
            avatarImageView.trailingAnchor.constraint(equalTo: actionsContainer.trailingAnchor, constant: Margin.mini.trailing),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupShareButton() {
        actionsContainer.addSubview(messageButton)
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.setup(inactiveImage: Image.comment, activeImage: Image.shareFilled)
        messageButton.addTarget(self, action: #selector(tapShareButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            messageButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.normal.top),
            messageButton.centerXAnchor.constraint(equalTo: actionsContainer.centerXAnchor),
            messageButton.heightAnchor.constraint(equalToConstant: 25),
            messageButton.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func setupLikeButton() {
        actionsContainer.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setup(inactiveImage: Image.like, activeImage: Image.likeFilled)
        likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: messageButton.bottomAnchor, constant: Margin.normal.top),
            likeButton.centerXAnchor.constraint(equalTo: actionsContainer.centerXAnchor),
            likeButton.bottomAnchor.constraint(equalTo: actionsContainer.bottomAnchor, constant: Margin.normal.bottom),
            likeButton.heightAnchor.constraint(equalToConstant: 25),
            likeButton.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func setupForProfile() {
        authorLabel.isHidden = true
        avatarImageView.isHidden = true

        messageContainer.willRemoveSubview(authorLabel)
        actionsContainer.willRemoveSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: messageContainer.topAnchor, constant: Margin.normal.top),
            messageButton.topAnchor.constraint(equalTo: actionsContainer.topAnchor, constant: Margin.normal.top)
        ])
    }
    
    func setupDate(_ date: String?) -> String {
        guard let time = date?.date(dateStyle: .omitted, timeStyle: .shortened),
              let fullDate = date?.date(dateStyle: .abbreviated, timeStyle: .omitted) else {
            return String.empty
        }

        return time + String.pauseWithSpaces + fullDate
    }
}
