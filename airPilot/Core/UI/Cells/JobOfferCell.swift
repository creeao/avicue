//
//  JobOfferCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol JobOfferCellDelegate: AnyObject {
    func tapJobOfferCell(id: Int)
}

class JobOfferCell: TableViewCell {
    // MARK: External properties
    weak var delegate: JobOfferCellDelegate?
    
    // MARK: Private properties
    private let logoImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let companyLabel = UILabel()
    private let positionLabel = UILabel()
    private let salaryLabel = UILabel()
    
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
extension JobOfferCell {
    func setup(with jobOffer: JobOfferModel, inCompany: Bool = false) {
        id = jobOffer.id
        logoImageView.getImage(from: jobOffer.assignedTo?.logo)
        companyLabel.text = jobOffer.assignedTo?.name
        positionLabel.text = jobOffer.position
        salaryLabel.text = setupSalary(with: jobOffer)
        
        if inCompany {
            setupForCompany()
        }
    }
}

// MARK: Events
private extension JobOfferCell {
    @objc func tapJobOfferCell() {
        delegate?.tapJobOfferCell(id: id)
    }
}
    
// MARK: Private methods
private extension JobOfferCell {
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
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.small.top),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.small.bottom),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Size.logo),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Size.logo)
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
        
        setupCompanyLabel()
        setupPositionLabel()
        setupSalaryLabel()
    }
    
    func setupCompanyLabel() {
        labelsContainerView.addSubview(companyLabel)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.font = Font.smallMedium
        companyLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            companyLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
        ])
    }
    
    func setupPositionLabel() {
        labelsContainerView.addSubview(positionLabel)
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.font = Font.bigSemiBold
        positionLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: Margin.tiny.top),
            positionLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            positionLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor)
        ])
    }
    
    func setupSalaryLabel() {
        labelsContainerView.addSubview(salaryLabel)
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryLabel.font = Font.normalSemiBold
        salaryLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            salaryLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: Margin.mini.top),
            salaryLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            salaryLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor),
        ])
    }
    
    func setupForCompany() {
        companyLabel.font = Font.miniMedium
        positionLabel.font = Font.normalSemiBold
        salaryLabel.font = Font.miniMedium
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapJobOfferCell))
        contentView.addGestureRecognizer(action)
        contentView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Size.smallLogo),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Size.smallLogo)
        ])
    }
    
    func setupSalary(with offer: JobOfferModel) -> String {
        guard let min = offer.minSalary, let max = offer.maxSalary, let currency = offer.currency else { return String.empty }
        return min.getAmount(with: currency) + " - " + max.getAmount(with: currency)
    }
}
