//
//  TitleView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit


class TitleView: UIView {
    // MARK: Private properties
    private let label = UILabel()
    
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
extension TitleView {
    func set(text: String) {
        label.text = text
    }
}

// MARK: Private methods
private extension TitleView {
    func setupView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.miniMedium
        label.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.small.leading),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
