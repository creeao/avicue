//
//  GroupCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/01/2023.
//

import UIKit

final class GroupCell: TableViewCell {
    // MARK: Private properties
    private var model: GroupModel? = nil
    private let logoImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let nameLabel = UILabel()
    private let industryLabel = UILabel()
    
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
extension GroupCell {
    func setup(with groupModel: GroupModel) {
        id = groupModel.id
        model = groupModel
        logoImageView.getImage(from: groupModel.logo)
        nameLabel.text = groupModel.name
        industryLabel.text = groupModel.headline
    }
    
    func getModel() -> GroupModel? {
        return model
    }
}
    
// MARK: Private methods
private extension GroupCell {
    func setupView() {
        setupLogoImageView()
        setupLabelsContainerView()
    }
    
    func setupLogoImageView() {
        containerView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.little.top),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.little.leading),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.little.bottom),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Size.smallLogo),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Size.smallLogo)
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
        setupIndustryLabel()
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
    
    func setupIndustryLabel() {
        labelsContainerView.addSubview(industryLabel)
        industryLabel.translatesAutoresizingMaskIntoConstraints = false
        industryLabel.font = Font.smallRegular
        industryLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            industryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.tiny.top),
            industryLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            industryLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            industryLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor),
        ])
    }
}
