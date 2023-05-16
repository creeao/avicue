//
//  GroupProfileCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/12/2022.
//

import UIKit

protocol GroupProfileCellDelegate: AnyObject {
    func showPosts(groupId: Int)
    func showMembers(groupId: Int)
    
    func showCalendar(calendarId: Int)
    func showMessages(conversationId: Int)
}

class GroupProfileCell: TableViewCell {
    // MARK: External properties
    weak var delegate: GroupProfileCellDelegate?
    
    // MARK: Private properties
    private var model: GroupModel? = nil
    private let imagesContainerView = UIView()
    private let backgroundImageView = UIImageView()
    private let avatarImageView = UIImageView()
    
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let headlineLabel = UILabel()
    
    private let numbersContainerView = UIStackView()
    private let postsView = NumberTextView()
    private let membersView = NumberTextView()
    
    private let buttonsContainer = UIStackView()
    private let calendarButton = PillButton()
    private let messagesButton = PillButton()
    
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
extension GroupProfileCell {
    func setup(with profile: GroupModel) {
        id = profile.id
        model = profile
        
        backgroundImageView.getImage(from: profile.background)
        avatarImageView.getImage(from: profile.logo)
        
        nameLabel.text = profile.name
        headlineLabel.text = profile.headline
        
        postsView.setup(number: profile.postsCount, text: "Posts")
        membersView.setup(number: profile.membersCount, text: "Members")
    }
}

// MARK: Events
private extension GroupProfileCell {
    @objc func tapPostsCount() {
        delegate?.showPosts(groupId: id)
    }
    
    @objc func tapMembersCount() {
        delegate?.showMembers(groupId: id)
    }
    
    @objc func tapCalendarButton() {
        guard let calendarId = model?.calendar?.id else { return }
        delegate?.showCalendar(calendarId: calendarId)
    }
    
    @objc func tapMessagesButton() {
        guard let conversationId = model?.conversation?.id else { return }
        delegate?.showMessages(conversationId: conversationId)
    }
}

// MARK: Private methods
private extension GroupProfileCell {
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
        setupHeadlineLabel()
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
    
    func setupHeadlineLabel() {
        labelsContainerView.addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.font = Font.smallMedium
        headlineLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.mini.top),
            headlineLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            headlineLabel.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
        ])
    }

    func setupNumbersContainerView() {
        containerView.addSubview(numbersContainerView)
        numbersContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numbersContainerView.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: Margin.huge.top),
            numbersContainerView.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor)
        ])
        
        setupPostsView()
        setupMembersView()
    }
    
    func setupPostsView() {
        numbersContainerView.addSubview(postsView)
        postsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postsView.topAnchor.constraint(equalTo: numbersContainerView.topAnchor),
            postsView.leadingAnchor.constraint(equalTo: numbersContainerView.leadingAnchor),
            postsView.bottomAnchor.constraint(equalTo: numbersContainerView.bottomAnchor),
            postsView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setupMembersView() {
        numbersContainerView.addSubview(membersView)
        membersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            membersView.topAnchor.constraint(equalTo: numbersContainerView.topAnchor),
            membersView.bottomAnchor.constraint(equalTo: numbersContainerView.bottomAnchor),
            membersView.leadingAnchor.constraint(equalTo: postsView.trailingAnchor, constant: Margin.huge.leading),
            membersView.trailingAnchor.constraint(equalTo: numbersContainerView.trailingAnchor),
            membersView.widthAnchor.constraint(equalToConstant: 70)
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
        
        setupCalendarButton()
        setupMessagesButton()
    }

    func setupCalendarButton() {
        calendarButton.setup(with: "Calendar")
        calendarButton.set(width: 120)
        calendarButton.addAction(self, #selector(tapCalendarButton))
        buttonsContainer.addArrangedSubview(calendarButton)
    }
    
    func setupMessagesButton() {
        messagesButton.setup(with: "Send message")
        messagesButton.set(width: 120)
        messagesButton.addAction(self, #selector(tapMessagesButton))
        buttonsContainer.addArrangedSubview(messagesButton)
    }
}

