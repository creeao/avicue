//
//  LargeTitleCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class LargeTitleCell: CustomTableViewCell {
    // MARK: Private properties
    private let label = UILabel()
    
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
extension LargeTitleCell {
    func setup(with text: String, toLeft: Bool = false) {
        label.text = text
        
        if toLeft {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading)
            ])
        } else {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading)
            ])
        }
    }
}

// MARK: Private methods
private extension LargeTitleCell {
    func setupView() {
        setupContainerView()
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.tremendousBold
        label.textColor = Color.black
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

