//
//  NumberTextView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class NumberTextView: UIView {
    // MARK: Private properties
    private let numberLabel = UILabel()
    private let textLabel = UILabel()
    
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
extension NumberTextView {
    func setup(number: Int?, text: String) {
        numberLabel.text = number.orZero.toString
        textLabel.text = text
    }
}

// MARK: Private methods
private extension NumberTextView {
    func setupView() {
        setupNumberLabel()
        setupTextLabel()
    }
    
    func setupNumberLabel() {
        addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.textColor = Color.black
        numberLabel.font = Font.hugeSemiBold
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: topAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTextLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = Font.smallMedium
        textLabel.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
