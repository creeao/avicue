//
//  SpaceCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class SpaceCell: CustomTableViewCell {
    // MARK: Private properties
    private let view = UIView()
    
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
extension SpaceCell {
    func setup(with height: CGFloat) {
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
    
// MARK: Private methods
private extension SpaceCell {
    func setupView() {
        setupContainerView()
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
