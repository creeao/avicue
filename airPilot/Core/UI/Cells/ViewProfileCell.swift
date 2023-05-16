//
//  ViewProfileCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//

import UIKit

protocol ViewProfileCellDelegate: AnyObject {
    func showProfile()
}

class ViewProfileCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: ViewProfileCellDelegate?
    
    // MARK: Private properties
    private let avatarImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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
extension ViewProfileCell {
    func setup(with model: UserModel?) {
        avatarImageView.getImage(from: model?.avatar)
        nameLabel.text = model?.getName()
    }
}

// MARK: Events
private extension ViewProfileCell {
    @objc func showProfile() {
        delegate?.showProfile()
    }
}
    
// MARK: Private methods
private extension ViewProfileCell {
    func setupView() {
        setupContainerView()
        setupAvatarImageView()
        setupLabelsContainerView()
        setupGesture()
    }
    
    func setupAvatarImageView() {
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
        setupDescriptionLabel()
    }
    
    func setupNameLabel() {
        labelsContainerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Font.bigBold
        nameLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
        ])
    }
    
    func setupDescriptionLabel() {
        labelsContainerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = Font.smallRegular
        descriptionLabel.textColor = Color.gray
        descriptionLabel.text = "View profile"
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.tiny.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor),
        ])
    }
    
    func setupGesture() {
        containerView.addGesture(self, #selector(showProfile))
    }
}
