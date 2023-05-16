//
//  UserCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 14/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

final class UserCell: TableViewCell {
    // MARK: Private properties
    private var userUuid: String = String.empty
    private let avatarImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let headlineLabel = UILabel()
    
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
extension UserCell {
    func setup(with model: UserModel) {
        userUuid = model.uuid
        avatarImageView.getImage(from: model.avatar)
        nameLabel.text = model.getName()
        headlineLabel.text = model.headline
    }
    
    func getUuid() -> String {
        return userUuid
    }
}
    
// MARK: Private methods
private extension UserCell {
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
        setupHeadlineLabel()
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
    
    func setupHeadlineLabel() {
        labelsContainerView.addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.font = Font.smallRegular
        headlineLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.tiny.top),
            headlineLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            headlineLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor),
        ])
    }
}
