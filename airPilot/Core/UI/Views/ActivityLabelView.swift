//
//  ActivityLabelView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 03/12/2022.
//

import UIKit

protocol ActivityLabelViewDelegate: AnyObject {
    func tapUser(userUuid: String)
}

class ActivityLabelView: UIView {
    // MARK: External properties
    weak var delegate: ActivityLabelViewDelegate?
    
    // MARK: Private properties
    private let avatar = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private var firstUserUuid: String = String.empty
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension ActivityLabelView {
    func setup(friendsActivity: [UserActivity], description: String?) {
        firstUserUuid = (friendsActivity.first?.user?.uuid).orEmpty
        avatar.getImage(from: friendsActivity.first?.user?.avatar)
        nameLabel.text = friendsActivity.first?.user?.getName()
        
        if friendsActivity.count == 1 {
            descriptionLabel.text = String.space + description.orEmpty
        } else if friendsActivity.count > 1 {
            descriptionLabel.text = String.space + "and \((friendsActivity.count - 1).toString) friends" + description.orEmpty
        }
    }
}

// MARK: Events
private extension ActivityLabelView {
    @objc func tapUser() {
        delegate?.tapUser(userUuid: firstUserUuid)
    }
}

// MARK: Private methods
private extension ActivityLabelView {
    func setupView() {
        setupAvatar()
        setupNameLabel()
        setupDescriptionLabel()
        setupGesture()
    }
    
    func setupAvatar() {
        addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = Constants.smallerCornerRadius
        avatar.set(width: 26, height: 26)
        avatar.addShadow()
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: topAnchor),
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Font.normalBold
        nameLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: Margin.small.leading)
        ])
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Font.normalMedium
        descriptionLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(
            target: self,
            action: #selector(tapUser))
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
}
