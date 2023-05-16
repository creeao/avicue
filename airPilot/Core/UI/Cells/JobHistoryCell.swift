//
//  JobHistoryCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 13/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol JobHistoryCellDelegate: AnyObject {
    func tapView(model: JobHistoryModel)
}

class JobHistoryCell: TableViewCell {
    // MARK: External properties
    weak var delegate: JobHistoryCellDelegate?
    
    // MARK: Private properties
    private var model: JobHistoryModel? = nil
    private let logoImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let companyLabel = UILabel()
    private let positionLabel = UILabel()
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
extension JobHistoryCell {
    func setup(with job: JobHistoryModel) {
        id = job.id
        ownerUuid = (job.createdBy?.uuid).orEmpty
        logoImageView.getImage(from: job.assignedTo?.logo)
        companyLabel.text = job.assignedTo?.name
        positionLabel.text = job.position
        descriptionLabel.text = setupDate(with: job.startDate, and: job.endDate)
        model = job
    }
}

// MARK: Events
private extension JobHistoryCell {
    @objc func tapView() {
        guard let model else { return }
        delegate?.tapView(model: model)
    }
}
    
// MARK: Private methods
private extension JobHistoryCell {
    func setupView() {
        setupLogoImageView()
        setupLabelsContainerView()
        setupGesture()
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
        
        setupCompanyLabel()
        setupPositionLabel()
        setupDescriptionLabel()
    }
    
    func setupCompanyLabel() {
        labelsContainerView.addSubview(companyLabel)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.font = Font.miniMedium
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
        positionLabel.font = Font.normalSemiBold
        positionLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: Margin.tiny.top),
            positionLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            positionLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor)
        ])
    }
    
    func setupDescriptionLabel() {
        labelsContainerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Font.miniMedium
        descriptionLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: Margin.mini.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor),
        ])
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(target: self, action: #selector(tapView))
        contentView.addGestureRecognizer(action)
        contentView.isUserInteractionEnabled = true
    }
    
    func setupDate(with startDate: String?, and endDate: String?) -> String {
        guard let startDate = startDate?.date() else {
            return String.empty
        }
        
        guard let endDate = endDate?.date() else {
            return startDate + String.pauseWithSpaces + "present"
        }
        
        return startDate + String.pauseWithSpaces + endDate
    }
}
