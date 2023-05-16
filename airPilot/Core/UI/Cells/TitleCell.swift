//
//  TitleCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class TitleCell: CustomTableViewCell {
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
extension TitleCell {
    func setup(with text: String, font: UIFont = Font.miniMedium, color: UIColor = Color.gray) {
        label.text = text
        label.font = font
        label.textColor = color
    }
}
    
// MARK: Private methods
private extension TitleCell {
    func setupView() {
        setupContainerView(verticalMargin: Margin.zero)
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.small.top),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
