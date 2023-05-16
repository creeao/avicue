//
//  ButtonsView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 20/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol ButtonsViewDelegate: AnyObject {
    func tapFirstButton()
    func tapSecondButton()
    func tapThirdButton()
}

class ButtonsView: UIView {
    // MARK: External properties
    weak var delegate: ButtonsViewDelegate?
    
    // MARK: Private properties
    private let stackView = UIStackView()
    private let firstButton = Button()
    private let secondButton = Button()
    private let thirdButton = Button()
    
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
extension ButtonsView {
    func setup(firstButtonTitle: String? = nil, secondButtonTitle: String? = nil, thirdButtonTitle: String? = nil, backgroundColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor.isNotNil ? backgroundColor : Color.transparent
        
        if secondButtonTitle.isNil && thirdButtonTitle.isNil {
            setupOneButton(firstButtonTitle: firstButtonTitle)
        } else if thirdButtonTitle.isNil {
            setupTwoButtons(firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle)
        } else {
            setupAllButtons(firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle, thirdButtonTitle: thirdButtonTitle)
        }
    }
}

// MARK: Events
private extension ButtonsView {
    @objc func tapFirstButton() {
        delegate?.tapFirstButton()
    }
    
    @objc func tapSecondButton() {
        delegate?.tapSecondButton()
    }
    
    @objc func tapThirdButton() {
        delegate?.tapThirdButton()
    }
}

// MARK: Private methods
private extension ButtonsView {
    func setupView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Margin.normal.space
        stackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.normal.bottom)
        ])
        
        firstButton.addTarget(self, action: #selector(tapFirstButton), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(tapSecondButton), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(tapThirdButton), for: .touchUpInside)
    }
    
    func setupAllButtons(firstButtonTitle: String?, secondButtonTitle: String?, thirdButtonTitle: String?) {
        stackView.addArrangedSubview(firstButton)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.setup(for: .enable, with: firstButtonTitle.orEmpty)
        
        let horizontalStackView = UIStackView()
        stackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Margin.regular.space
        horizontalStackView.distribution = .fillEqually
        
        horizontalStackView.addArrangedSubview(secondButton)
//        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.setup(for: .dashed, with: secondButtonTitle.orEmpty)
        
        horizontalStackView.addArrangedSubview(thirdButton)
//        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.setup(for: .dashed, with: thirdButtonTitle.orEmpty)
    }
    
    func setupTwoButtons(firstButtonTitle: String?, secondButtonTitle: String?) {
        stackView.addArrangedSubview(firstButton)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.setup(for: .enable, with: firstButtonTitle.orEmpty)
        
        stackView.addArrangedSubview(secondButton)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.setup(for: .dashed, with: secondButtonTitle.orEmpty)
    }
    
    func setupOneButton(firstButtonTitle: String?) {
        stackView.addArrangedSubview(firstButton)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.setup(for: .enable, with: firstButtonTitle.orEmpty)
    }
}
