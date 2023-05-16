//
//  TableViewCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: External properties
    var id: Int = 0
    var ownerUuid: String = String.empty
    let containerView = UIView()
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContainerView()
    }
}

// MARK: External methods
extension TableViewCell {
    func getId() -> Int {
        return id
    }
}

// MARK: Private methods
private extension TableViewCell {
    func setupContainerView() {
        selectionStyle = .none
        backgroundColor = Color.transparent
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.backgroundColor = Color.white
        containerView.addShadow()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.small.top),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.normal.leading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margin.normal.trailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Margin.small.bottom),
        ])
    }
}
