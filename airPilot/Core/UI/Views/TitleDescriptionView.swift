//
//  TitleDescriptionView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class TitleDescriptionView: UIView {
    // MARK: Private properties
    private let titleLabel = UILabel()
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
extension TitleDescriptionView {
    func setup(with model: InformationModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}

// MARK: Private methods
private extension TitleDescriptionView {
    func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Color.white
        addShadow()
        
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.miniMedium
        titleLabel.textColor = Color.gray
        titleLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin.regular.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = Color.black
        descriptionLabel.font = Font.normalSemiBold
        descriptionLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.tiny.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.normal.trailing),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.regular.bottom),
        ])
    }
}
