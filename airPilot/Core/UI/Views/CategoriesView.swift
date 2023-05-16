//
//  CategoriesView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol CategoriesViewDelegate: AnyObject {
    func tapJobOffersButton()
    func tapApartmentOffersButton()
    func tapPlaneOffersButton()
}

final class CategoriesView: UIView {
    // MARK: External properties
    weak var delegate: CategoriesViewDelegate?
    
    // MARK: Private properties
    private var stackView = UIStackView()
    private var jobsButton = PillButton()
    private var apartmentsButton = PillButton()
    private var planesButton = PillButton()
    
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

// MARK: Events
private extension CategoriesView {
    @objc func tapJobOffersButton() {
        delegate?.tapJobOffersButton()
    }
    
    @objc func tapApartmentOffersButton() {
        delegate?.tapApartmentOffersButton()
    }
    
    @objc func tapPlaneOffersButton() {
        delegate?.tapPlaneOffersButton()
    }
}

// MARK: Private methods
private extension CategoriesView {
    func setupView() {
        backgroundColor = Color.white
        layer.cornerRadius = Constants.cornerRadius
        
        addShadow()
        setupStackView()
        setupElements()
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Margin.medium.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.medium.top),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.medium.leading),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.medium.trailing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.medium.bottom)
        ])
    }
    
    func setupElements() {
        [jobsButton, apartmentsButton, planesButton].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupJobsButton()
        setupApartmentsButton()
        setupPlanesButton()
    }
    
    func setupJobsButton() {
        jobsButton.setup(with: "Jobs", and: Image.jobs)
        jobsButton.addTarget(self, action: #selector(tapJobOffersButton), for: .touchUpInside)
    }
    
    func setupApartmentsButton() {
        apartmentsButton.setup(with: "Apartments", and: Image.apartments)
        apartmentsButton.addTarget(self, action: #selector(tapApartmentOffersButton), for: .touchUpInside)
    }
    
    func setupPlanesButton() {
        planesButton.setup(with: "Planes", and: Image.airplane)
        planesButton.addTarget(self, action: #selector(tapPlaneOffersButton), for: .touchUpInside)
    }
}
