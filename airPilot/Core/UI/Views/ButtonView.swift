//
//  ButtonView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 20/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol ButtonViewDelegate: AnyObject {
    func tapButton()
}

class ButtonView: UIView {
    // MARK: External properties
    weak var delegate: ButtonViewDelegate?
    
    // MARK: Private properties
    private let button = Button()
    
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
extension ButtonView {
    func setup(style: ButtonStyle, title: String, backgroundColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor.isNotNil ? backgroundColor : Color.transparent
        button.setup(for: style, with: title)
    }
}

// MARK: Events
private extension ButtonView {
    @objc func tapButton() {
        delegate?.tapButton()
    }
}

// MARK: Private methods
private extension ButtonView {
    func setupView() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.normal.bottom)
        ])
    }
}
