//
//  JobHistoryView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/12/2022.
//

import UIKit

protocol JobHistoryViewDelegate: AnyObject {
    func openCompany(companyId: Int)
    func removeHistory(id: Int)
}

final class JobHistoryView: UIView {
    // MARK: External properties
    weak var delegate: JobHistoryViewDelegate?
    
    // MARK: Private properties
    private var model: JobHistoryModel? = nil
    private let containerView = UIView()
    private let logoImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let companyLabel = UILabel()
    private let positionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let removeButton = Button()
    
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
extension JobHistoryView {
    func setup(with job: JobHistoryModel, inEditView: Bool = false) {
        logoImageView.getImage(from: job.assignedTo?.logo)
        companyLabel.text = job.assignedTo?.name
        positionLabel.text = job.position
        descriptionLabel.text = setupDate(with: job.startDate, and: job.endDate)
        model = job
        
        if inEditView {
            removeButton.isHidden = false
        }
    }
    
    func getModel() -> JobHistoryModel? {
        return model
    }
}

// MARK: Events
private extension JobHistoryView {
    @objc func tapCompanyLogo() {
        guard let companyId = model?.assignedTo?.id else { return }
        delegate?.openCompany(companyId: companyId)
    }
    
    @objc func tapRemoveButton() {
        guard let id = model?.id else { return }
        delegate?.removeHistory(id: id)
    }
}

// MARK: Private
private extension JobHistoryView {
    func setupView() {
        setupContainerView()
        setupLogoImageView()
        setupLabelsContainerView()
        setupGesture()
        setupRemoveButton()
    }
    
    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.backgroundColor = Color.white
        containerView.addShadow()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.small.bottom),
        ])
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
    
    func setupRemoveButton() {
        containerView.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.set(width: 36, height: 36)
        removeButton.isHidden = true
        removeButton.addTarget(self, action: #selector(tapRemoveButton), for: .touchUpInside)
        removeButton.setup(for: .filledImage, and: Image.closeButton)
        
        NSLayoutConstraint.activate([
            removeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.large.trailing),
            removeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(target: self, action: #selector(tapCompanyLogo))
        logoImageView.addGestureRecognizer(action)
        logoImageView.isUserInteractionEnabled = true
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

