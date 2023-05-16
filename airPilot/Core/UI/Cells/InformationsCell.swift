//
//  InformationsCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class InformationsCell: CustomTableViewCell {
    // MARK: Private properties
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    
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
extension InformationsCell {
    func setup(with informations: [InformationModel]) {
        guard informations.count > 0 else { return }
        for index in 0...(informations.count - 1) {
            switch index {
            case 0:
                appendToLeftStackView(with: informations[index])
            case 1:
                appendToRightStackView(with: informations[index])
            default:
                if index.isMultiple(of: 2) {
                    appendToLeftStackView(with: informations[index])
                } else {
                    appendToRightStackView(with: informations[index])
                }
            }
        }
    }
}

// MARK: Private methods
private extension InformationsCell {
    func setupView() {
        setupContainerView()
        setupLeftStackView()
        setupRightStackView()
    }
    
    func setupLeftStackView() {
        let width = UIScreen.main.bounds.size.width
        let paddingElement = (width / 2) - 24
        
        containerView.addSubview(leftStackView)
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.distribution = .equalCentering
        leftStackView.axis = .vertical
        leftStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            leftStackView.widthAnchor.constraint(equalToConstant: paddingElement),
            leftStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupRightStackView() {
        let width = UIScreen.main.bounds.size.width
        let paddingElement = (width / 2) - 20
        
        containerView.addSubview(rightStackView)
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.axis = .vertical
        rightStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            rightStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rightStackView.widthAnchor.constraint(equalToConstant: paddingElement)
        ])
    }
    
    func appendToLeftStackView(with model: InformationModel) {
        let view = TitleDescriptionView()
        view.setup(with: model)
        leftStackView.addArrangedSubview(view)
    }
    
    func appendToRightStackView(with model: InformationModel) {
        let view = TitleDescriptionView()
        view.setup(with: model)
        rightStackView.addArrangedSubview(view)
    }
}
