//
//  Container.swift
//  airPilot
//
//  Created by Eryk Chrustek on 31/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class Container: UIView {
    // MARK: External properties
    let containerView = UIView()

    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContainerView()
    }
}

// MARK: External methods
extension Container {
    func setupContainerView() {
        backgroundColor = Color.transparent
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.backgroundColor = Color.white
        containerView.addShadow()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.small.bottom)
        ])
    }
}
