//
//  DescriptionCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class DescriptionCell: TableViewCell {
    // MARK: Private properties
    private let titleLabel = UILabel()
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
extension DescriptionCell {
    func setup(with description: String?) {
        descriptionLabel.text = description.orEmpty
    }
}

// MARK: Private methods
private extension DescriptionCell {
    func setupView() {
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.miniMedium
        titleLabel.textColor = Color.gray
        titleLabel.text = "Description"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.regular.top),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func setupDescriptionLabel() {
        containerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = Color.black
        descriptionLabel.font = Font.largeRegular
        descriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.tiny.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.normal.trailing),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.regular.bottom),
        ])
    }
}

