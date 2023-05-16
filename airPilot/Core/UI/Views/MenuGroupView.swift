//
//  MenuGroupView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/12/2022.
//

import UIKit

protocol MenuGroupViewDelegate: AnyObject {
    func showGroup(groupId: Int)
}

final class MenuGroupView: UIView {
    // MARK: External properties
    weak var delegate: MenuGroupViewDelegate?
    
    // MARK: Private properties
    private var model: GroupModel? = nil
    private let containerView = UIView()
    private let logoImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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
extension MenuGroupView {
    func setup(with model: GroupModel, and description: String) {
        self.model = model
        logoImageView.getImage(from: model.logo)
        nameLabel.text = model.name
        descriptionLabel.text = description
    }
    
    func getModel() -> GroupModel? {
        return model
    }
}

// MARK: Events
private extension MenuGroupView {
    @objc func tapGroup() {
        delegate?.showGroup(groupId: (model?.id).orZero)
    }
}

// MARK: Private
private extension MenuGroupView {
    func setupView() {
        setupContainerView()
        setupLogoImageView()
        setupLabelsContainerView()
        setupGesture()
    }
    
    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupLogoImageView() {
        containerView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = Constants.cornerRadius
        logoImageView.addShadow()
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.little.leading),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLabelsContainerView() {
        containerView.addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsContainerView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Margin.small.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.small.trailing),
            labelsContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        setupNameLabel()
        setupDescriptionLabel()
    }
    
    func setupNameLabel() {
        labelsContainerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Font.normalSemiBold
        nameLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor)
        ])
    }
    
    func setupDescriptionLabel() {
        labelsContainerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Font.miniMedium
        descriptionLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.tiny.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
        ])
    }
    
    func setupGesture() {
        addGesture(self, #selector(tapGroup))
        logoImageView.addGesture(self, #selector(tapGroup))
    }
}

