//
//  UIStackView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension ViewController {
    func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Margin.normal.space
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: Margin.normal.space,
            left: Margin.zero.space,
            bottom: Margin.normal.space,
            right: Margin.zero.space)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
        ])
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
        }
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
