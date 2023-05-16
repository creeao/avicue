//
//  JobOfferView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 03/12/2022.
//

import UIKit

protocol JobOfferViewDelegate: AnyObject {
    func tapJobOffer(offerId: Int)
}

final class JobOfferView: UIView {
    // MARK: External properties
    weak var delegate: JobOfferViewDelegate?
    
    // MARK: Private properties
    private let logoImageView = UIImageView()
    private let labelsContainerView = UIView()
    private let companyLabel = UILabel()
    private let positionLabel = UILabel()
    private let salaryLabel = UILabel()
    
    private var offerId: Int = 0
    
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
extension JobOfferView {
    func setup(with offer: JobOfferModel, inCompany: Bool = false) {
        offerId = offer.id
        logoImageView.getImage(from: offer.assignedTo?.logo)
        companyLabel.text = offer.assignedTo?.name
        positionLabel.text = offer.position
        salaryLabel.text = setupSalary(with: offer)
        
        if inCompany {
            setupForCompany()
        }
    }
}

// MARK: Events
private extension JobOfferView {
    @objc func tapJobOfferView() {
        delegate?.tapJobOffer(offerId: offerId)
    }
}

// MARK: Private methods
private extension JobOfferView {
    func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Color.white
        
        setupLogoImageView()
        setupLabelsContainerView()
        setupGesture()
    }
    
    func setupLogoImageView() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.small.leading),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.small.bottom),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Size.logo),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Size.logo)
        ])
    }
    
    func setupLabelsContainerView() {
        addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsContainerView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Margin.small.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.small.trailing),
            labelsContainerView.centerYAnchor.constraint(equalTo: centerYAnchor)
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
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Size.smallLogo),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Size.smallLogo)
        ])
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(
            target: self,
            action: #selector(tapJobOfferView))
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
    
    func setupSalary(with offer: JobOfferModel) -> String {
        guard let min = offer.minSalary, let max = offer.maxSalary, let currency = offer.currency else { return String.empty }
        return min.getAmount(with: currency) + " - " + max.getAmount(with: currency)
    }
}
