//
//  AvatarBackgroundPickerCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/12/2022.
//

import UIKit

protocol AvatarBackgroundPickerCellDelegate: AnyObject {
    func addAvatar()
    func addBackground()
}

class AvatarBackgroundPickerCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: AvatarBackgroundPickerCellDelegate?
    
    // MARK: Private properties
    private let avatarContainer = UIView()
    private let avatarImageView = UIImageView()
    private let avatarStackView = UIStackView()
    private let avatarIconView = UIImageView()
    private let avatarLabel = UILabel()
    
    private let backgroundContainer = UIView()
    private let backgroundImageView = UIImageView()
    private let backgroundStackView = UIStackView()
    private let backgroundIconView = UIImageView()
    private let backgroundLabel = UILabel()
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        setupBorders()
    }
}

// MARK: External methods
extension AvatarBackgroundPickerCell {
    func setAvatar(image: UIImage? = nil, id: String? = nil) {
        if let image {
            avatarImageView.image = image
            avatarImageView.isHidden = false
            avatarContainer.isHidden = true
        } else if let id {
            avatarImageView.getImage(from: id)
            avatarImageView.isHidden = false
            avatarContainer.isHidden = true
        }
    }
    
    func setBackground(image: UIImage? = nil, id: String? = nil) {
        if let image {
            backgroundImageView.image = image
            backgroundImageView.isHidden = false
            backgroundContainer.isHidden = true
        } else if let id {
            backgroundImageView.getImage(from: id)
            backgroundImageView.isHidden = false
            backgroundContainer.isHidden = true
        }
    }
}

// MARK: Events
private extension AvatarBackgroundPickerCell {
    @objc func addAvatar() {
        delegate?.addAvatar()
    }
    
    @objc func addBackground() {
        delegate?.addBackground()
    }
}

// MARK: Private methods
private extension AvatarBackgroundPickerCell {
    func setupView() {
        setupContainerView()
        setupAvatarContainer()
        setupBackgroundContainer()
        setupBorders()
        setupGesture()
    }
    
    func setupBorders() {
        avatarContainer.setupDashedBorder()
        backgroundContainer.setupDashedBorder()
    }
    
    func setupAvatarContainer() {
        containerView.addSubview(avatarContainer)
        avatarContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.bringSubviewToFront(avatarContainer)
        
        NSLayoutConstraint.activate([
            avatarContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            avatarContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            avatarContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            avatarContainer.heightAnchor.constraint(equalToConstant: 130),
            avatarContainer.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        setupAvatarImageView()
        setupAvatarStackView()
        setupAvatarIconView()
        setupAvatarLabel()
    }
    
    func setupAvatarImageView() {
        containerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.isHidden = true
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        avatarImageView.clipsToBounds = true
        
        let editIcon = Button()
        avatarImageView.addSubview(editIcon)
        editIcon.translatesAutoresizingMaskIntoConstraints = false
        editIcon.setup(for: .whiteImage, and: Image.editButton)
        editIcon.addTarget(self, action: #selector(addAvatar), for: .touchUpInside)
        
        let avatarAction = UITapGestureRecognizer(target: self, action: #selector(addAvatar))
        avatarImageView.addGestureRecognizer(avatarAction)
        avatarImageView.isUserInteractionEnabled = true
        editIcon.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),

            editIcon.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            editIcon.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            editIcon.heightAnchor.constraint(equalToConstant: 40),
            editIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAvatarStackView() {
        avatarContainer.addSubview(avatarStackView)
        avatarStackView.translatesAutoresizingMaskIntoConstraints = false
        avatarStackView.axis = .vertical
        avatarStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            avatarStackView.centerYAnchor.constraint(equalTo: avatarContainer.centerYAnchor),
            avatarStackView.centerXAnchor.constraint(equalTo: avatarContainer.centerXAnchor)
        ])
    }
    
    func setupAvatarIconView() {
        avatarStackView.addArrangedSubview(avatarIconView)
        avatarIconView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarIconView.image = Image.addPhoto
        avatarIconView.set(width: 30, height: 30)
        avatarStackView.setCustomSpacing(Margin.small.space, after: avatarIconView)
    }
    
    func setupAvatarLabel() {
        avatarStackView.addArrangedSubview(avatarLabel)
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        avatarLabel.font = Font.bigSemiBold
        avatarLabel.textColor = Color.black
        avatarLabel.text = "Add avatar"
    }
    
    func setupBackgroundContainer() {
        containerView.addSubview(backgroundContainer)
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundContainer.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: Margin.medium.leading),
            backgroundContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundContainer.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        setupBackgroundImageView()
        setupBackgroundStackView()
        setupBackgroundIconView()
        setupBackgroundLabel()
    }
    
    func setupBackgroundImageView() {
        containerView.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.isHidden = true
        backgroundImageView.layer.cornerRadius = Constants.cornerRadius
        backgroundImageView.clipsToBounds = true
        
        let editIcon = Button()
        backgroundImageView.addSubview(editIcon)
        editIcon.translatesAutoresizingMaskIntoConstraints = false
        editIcon.setup(for: .whiteImage, and: Image.editButton)
        editIcon.addTarget(self, action: #selector(addBackground), for: .touchUpInside)
        
        let backgroundAction = UITapGestureRecognizer(target: self, action: #selector(addBackground))
        backgroundImageView.addGestureRecognizer(backgroundAction)
        backgroundImageView.isUserInteractionEnabled = true
        editIcon.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Margin.medium.leading),
            backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 110),
            
            editIcon.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            editIcon.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            editIcon.heightAnchor.constraint(equalToConstant: 40),
            editIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupBackgroundStackView() {
        backgroundContainer.addSubview(backgroundStackView)
        backgroundStackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStackView.axis = .vertical
        backgroundStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            backgroundStackView.centerYAnchor.constraint(equalTo: backgroundContainer.centerYAnchor),
            backgroundStackView.centerXAnchor.constraint(equalTo: backgroundContainer.centerXAnchor)
        ])
    }
    
    func setupBackgroundIconView() {
        let container = UIView()
        container.addSubview(backgroundIconView)
        backgroundIconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundIconView.topAnchor.constraint(equalTo: container.topAnchor),
            backgroundIconView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            backgroundIconView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            backgroundIconView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        backgroundStackView.addArrangedSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundIconView.backgroundColor = Color.white
        backgroundIconView.image = Image.addPhoto
        backgroundIconView.set(width: 30, height: 30)
        backgroundStackView.setCustomSpacing(Margin.small.space, after: backgroundIconView)
    }
    
    func setupBackgroundLabel() {
        backgroundStackView.addArrangedSubview(backgroundLabel)
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundLabel.font = Font.bigSemiBold
        backgroundLabel.textColor = Color.black
        backgroundLabel.text = "Add background"
    }
    
    func setupGesture() {
        let avatarAction = UITapGestureRecognizer(target: self, action: #selector(addAvatar))
        avatarContainer.addGestureRecognizer(avatarAction)
        avatarContainer.isUserInteractionEnabled = true
        
        let backgroundAction = UITapGestureRecognizer(target: self, action: #selector(addBackground))
        backgroundContainer.addGestureRecognizer(backgroundAction)
        backgroundContainer.isUserInteractionEnabled = true
    }
}
