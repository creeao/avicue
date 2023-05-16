//
//  CompanyProfileCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol CompanyProfileCellDelegate: AnyObject {
    func tapActionOnCompanyButton(actionOnCompany: ActionOnCompanyType)
    func tapWebsiteButton(url: String)
//    func tapMessageButton(userUuid: String)
}

class CompanyProfileCell: TableViewCell {
    // MARK: External properties
    weak var delegate: CompanyProfileCellDelegate?
    
    // MARK: Private properties
    private let imagesContainerView = UIView()
    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let headlineLabel = UILabel()
    
    private let buttonsContainer = UIStackView()
    private let actionOnCompanyButton = PillButton()
    private let websiteButton = PillButton()
    private var website = String.empty
    
    private var actionOnCompany: ActionOnCompanyType = .follow
    
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
extension CompanyProfileCell {
    func setup(with model: CompanyProfileModel) {
        backgroundImageView.getImage(from: model.background)
        logoImageView.getImage(from: model.company.logo)
        nameLabel.text = model.company.name
        headlineLabel.text = model.company.headline
        website = model.website.orEmpty
        setupButtons(model)
    }
}

// MARK: Events
private extension CompanyProfileCell {
    @objc func tapActionOnCompanyButton() {
        delegate?.tapActionOnCompanyButton(actionOnCompany: actionOnCompany)
        setupActionOnCompany()
    }
    
    @objc func tapWebsiteButton() {
        delegate?.tapWebsiteButton(url: website)
    }
}

// MARK: Private methods
private extension CompanyProfileCell {
    func setupView() {
        setupImageContainerView()
        setupLabelsContainerView()
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
        setupLogoImageView()
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
    
    func setupLogoImageView() {
        imagesContainerView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 50
        logoImageView.layer.borderWidth = 5
        logoImageView.layer.borderColor = Color.white.cgColor

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: imagesContainerView.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: imagesContainerView.centerXAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: imagesContainerView.bottomAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100)
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
        setupIndustryLabel()
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
    
    func setupIndustryLabel() {
        labelsContainerView.addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.font = Font.smallMedium
        headlineLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.mini.top),
            headlineLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            headlineLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
        ])
    }
    
    func setupButtonsContainer() {
        containerView.addSubview(buttonsContainer)
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainer.axis = .horizontal
        buttonsContainer.spacing = Margin.normal.space
        
        NSLayoutConstraint.activate([
            buttonsContainer.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: Margin.normal.top),
            buttonsContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom)
        ])
    }
    
//    func setupFollowButton() {
//        containerView.addSubview(followButton)
//        followButton.translatesAutoresizingMaskIntoConstraints = false
//        followButton.setup(with: "Follow")
//        followButton.set(width: 120)
//
//        NSLayoutConstraint.activate([
//            followButton.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: Margin.normal.top),
//            followButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            followButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom)
//        ])
//    }
    
    func setupActionOnCompany() {
        switch actionOnCompany {
        case .follow:
            actionOnCompanyButton.setTitle("Unfollow")
            actionOnCompany = .unfollow
        case .unfollow:
            actionOnCompanyButton.setTitle("Follow")
            actionOnCompany = .follow
        }
    }
    
    func setupButtons(_ model: CompanyProfileModel) {
        setupFollowButton(model.status)
        
        if let website = model.website, website.isNotEmpty {
            setupWebsiteButton()
        }
    }
    
    func setupFollowButton(_ status: CompanyRelationType?) {
        switch status {
        case .followed:
            actionOnCompanyButton.setup(with: "Unfollow")
            actionOnCompany = .unfollow
        case .noRelations:
            actionOnCompanyButton.setup(with: "Follow")
            actionOnCompany = .follow
        default:
            break
        }
        
        actionOnCompanyButton.set(width: 120)
        buttonsContainer.addArrangedSubview(actionOnCompanyButton)
        actionOnCompanyButton.translatesAutoresizingMaskIntoConstraints = false
        actionOnCompanyButton.addTarget(self, action: #selector(tapActionOnCompanyButton), for: .touchUpInside)
    }
    
    func setupWebsiteButton() {
        websiteButton.setup(with: "Website")
        websiteButton.set(width: 120)
        buttonsContainer.addArrangedSubview(websiteButton)
        websiteButton.translatesAutoresizingMaskIntoConstraints = false
        websiteButton.addTarget(self, action: #selector(tapWebsiteButton), for: .touchUpInside)
    }
}
