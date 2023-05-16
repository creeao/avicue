//
//  ProfileCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate: AnyObject {
    func tapActionOnUserButton(actionOnUser: ActionOnUserType)
    func tapFriendsCount(userUuid: String)
    func tapMessageButton(userUuid: String)
}

struct ProfileCellModel {
    let background: String?
    let avatar: String?
    let name: String?
    let position: String?
    let postsCount: String?
    let friendsCount: String?
    let followersCount: String?
    let actionOnUser: ActionOnUserType
}

class ProfileCell: TableViewCell {
    // MARK: External properties
    weak var delegate: ProfileCellDelegate?
    
    // MARK: Private properties
    private var userUuid: String = String.empty
    private let imagesContainerView = UIView()
    private let backgroundImageView = UIImageView()
    private let avatarImageView = UIImageView()
    
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let positionLabel = UILabel()
    
    private let numbersContainerView = UIStackView()
    private let postsView = NumberTextView()
    private let friendsView = NumberTextView()
    private let followersView = NumberTextView()
    
    private let buttonsContainer = UIStackView()
    private let actionOnUserButton = PillButton()
    private let sendMessageButton = PillButton()
    private let editProfileButton = PillButton()
    
    private var actionOnUser: ActionOnUserType = .unknow
    
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
extension ProfileCell {
    func setup(with profile: ProfileModel, isUserProfile: Bool) {
        userUuid = (profile.user?.uuid).orEmpty
        backgroundImageView.getImage(from: profile.background)
        avatarImageView.getImage(from: profile.user?.avatar)
        nameLabel.text = (profile.user?.firstName).isNotNil ? profile.user?.getName() : profile.user?.email
        positionLabel.text = profile.user?.headline
        postsView.setup(number: profile.postsCount, text: "Posts")
        friendsView.setup(number: profile.friendsCount, text: "Friends")
        followersView.setup(number: profile.followersCount, text: "Followers")
        
        if isUserProfile {
            setupActionOnUserButton(actionOnUser: .editProfile)
        } else {
            setupAnotherUserProfileButtons(type: profile.status ?? .unknow)
        }
    }
}

// MARK: Events
private extension ProfileCell {
    @objc func tapActionOnUserButton() {
        delegate?.tapActionOnUserButton(actionOnUser: actionOnUser)
        setupActionOnUser()
    }
    
    @objc func tapFriendsCount() {
        delegate?.tapFriendsCount(userUuid: userUuid)
    }
    
    @objc func tapMessageButton() {
        delegate?.tapMessageButton(userUuid: userUuid)
    }
}

// MARK: Private methods
private extension ProfileCell {
    func setupView() {
        setupImageContainerView()
        setupLabelsContainerView()
        setupNumbersContainerView()
        setupButtonsContainer()
    }
    
    func setupImageContainerView() {
        containerView.addSubview(imagesContainerView)
        imagesContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagesContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.small.top),
            imagesContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            imagesContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.small.trailing)
        ])
        
        setupBackgroundImageView()
        setupAvatarImageView()
    }
    
    func setupBackgroundImageView() {
        imagesContainerView.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: imagesContainerView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: imagesContainerView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: imagesContainerView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func setupAvatarImageView() {
        imagesContainerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 5
        avatarImageView.layer.borderColor = Color.white.cgColor

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: imagesContainerView.topAnchor, constant: 80),
            avatarImageView.centerXAnchor.constraint(equalTo: imagesContainerView.centerXAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: imagesContainerView.bottomAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupLabelsContainerView() {
        containerView.addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsContainerView.topAnchor.constraint(equalTo: imagesContainerView.bottomAnchor, constant: Margin.regular.top),
            labelsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.normal.trailing)
        ])
        
        setupNameLabel()
        setupPositionLabel()
    }
    
    func setupNameLabel() {
        labelsContainerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = Color.black
        nameLabel.font = Font.bigSemiBold
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor)
        ])
    }
    
    func setupPositionLabel() {
        labelsContainerView.addSubview(positionLabel)
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.font = Font.smallMedium
        positionLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.mini.top),
            positionLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            positionLabel.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
        ])
    }

    func setupNumbersContainerView() {
        containerView.addSubview(numbersContainerView)
        numbersContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numbersContainerView.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: Margin.huge.top),
            numbersContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.big.leading),
            numbersContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.big.trailing)
        ])
        
        setupFriendsView()
        setupPostsView()
        setupFollowersView()
    }
    
    func setupFriendsView() {
        numbersContainerView.addSubview(friendsView)
        friendsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            friendsView.topAnchor.constraint(equalTo: numbersContainerView.topAnchor),
            friendsView.bottomAnchor.constraint(equalTo: numbersContainerView.bottomAnchor),
            friendsView.centerXAnchor.constraint(equalTo: numbersContainerView.centerXAnchor),
            friendsView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapFriendsCount))
        friendsView.addGestureRecognizer(action)
    }
    
    func setupPostsView() {
        numbersContainerView.addSubview(postsView)
        postsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postsView.topAnchor.constraint(equalTo: numbersContainerView.topAnchor),
            postsView.bottomAnchor.constraint(equalTo: numbersContainerView.bottomAnchor),
            postsView.trailingAnchor.constraint(equalTo: friendsView.leadingAnchor, constant: Margin.huge.trailing),
            postsView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setupFollowersView() {
        numbersContainerView.addSubview(followersView)
        followersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            followersView.topAnchor.constraint(equalTo: numbersContainerView.topAnchor),
            followersView.bottomAnchor.constraint(equalTo: numbersContainerView.bottomAnchor),
            followersView.leadingAnchor.constraint(equalTo: friendsView.trailingAnchor, constant: Margin.huge.leading),
            followersView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setupButtonsContainer() {
        containerView.addSubview(buttonsContainer)
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainer.axis = .horizontal
        buttonsContainer.spacing = Margin.normal.space
        
        NSLayoutConstraint.activate([
            buttonsContainer.topAnchor.constraint(equalTo: numbersContainerView.bottomAnchor, constant: Margin.normal.top),
            buttonsContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom)
        ])
    }
    
    func setupUserProfileButton() {
        editProfileButton.setup(with: "Edit profile")
        editProfileButton.set(width: 120)
        buttonsContainer.addArrangedSubview(editProfileButton)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupAnotherUserProfileButtons(type: UsersRelationType) {
        switch type {
        case .friend:
            actionOnUser = .removeFriend
        case .invitationSent:
            actionOnUser = .cancelInvite
        case .invitationReceived:
            actionOnUser = .acceptInvite
        case .noRelations:
            actionOnUser = .sendInvite
        case .unknow:
            actionOnUser = .sendInvite
        }
        
        setupActionOnUserButton(actionOnUser: actionOnUser)
        setupSendMessageButton()
    }

    func setupActionOnUserButton(actionOnUser: ActionOnUserType) {
        actionOnUserButton.set(width: 120)
        buttonsContainer.addArrangedSubview(actionOnUserButton)
        actionOnUserButton.translatesAutoresizingMaskIntoConstraints = false
        actionOnUserButton.addTarget(self, action: #selector(tapActionOnUserButton), for: .touchUpInside)
        
        switch actionOnUser {
        case .sendInvite:
            actionOnUserButton.setup(with: "Send invite")
        case .cancelInvite:
            actionOnUserButton.setup(with: "Cancel invite")
        case .removeFriend:
            actionOnUserButton.setup(with: "Remove friend")
        case .acceptInvite:
            actionOnUserButton.setup(with: "Accept invite")
        case .follow:
            actionOnUserButton.setup(with: "Follow")
        case .unfollow:
            actionOnUserButton.setup(with: "Unfollow")
        case .editProfile:
            actionOnUserButton.setup(with: "Edit profile")
            self.actionOnUser = .editProfile
        case .unknow:
            break
        }
    }
    
    func setupActionOnUser() {
        switch actionOnUser {
        case .sendInvite:
            actionOnUserButton.setTitle("Cancel invite")
            actionOnUser = .cancelInvite
        case .cancelInvite:
            actionOnUserButton.setTitle("Send invite")
            actionOnUser = .sendInvite
        case .removeFriend:
            actionOnUserButton.setTitle("Send invite")
            actionOnUser = .sendInvite
        case .acceptInvite:
            actionOnUserButton.setTitle("Remove friend")
            actionOnUser = .removeFriend
        case .follow:
            actionOnUserButton.setTitle("Unfollow")
            actionOnUser = .unfollow
        case .unfollow:
            actionOnUserButton.setTitle("Follow")
            actionOnUser = .follow
        case .editProfile:
            actionOnUserButton.setTitle("Edit profile")
            actionOnUser = .editProfile
        case .unknow:
            break
        }
    }
    
    func setupSendMessageButton() {
        sendMessageButton.setup(with: "Send message")
        sendMessageButton.set(width: 120)
        buttonsContainer.addArrangedSubview(sendMessageButton)
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        sendMessageButton.addTarget(self, action: #selector(tapMessageButton), for: .touchUpInside)
    }

    func setupLocation(with location: Location) -> String {
        var additionalInformation = String.empty
        
        if let buildingNumber = location.buildingNumber {
            additionalInformation += buildingNumber
        }
        
        if let flatNumber = location.flatNumber {
            additionalInformation += (String.slash + flatNumber)
        }
        
        return (location.country?.rawValue).orEmpty + String.comma + location.street.orEmpty + String.space + additionalInformation
    }
}
