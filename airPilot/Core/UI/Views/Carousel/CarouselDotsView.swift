//
//  CarouselDotsView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class CarouselDotsView: UIView {
    // MARK: Private properties
    private var dots: [UIImageView] = []
    private var stackView = UIStackView()
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}

// MARK: External methods
extension CarouselDotsView {
    func setup(elements: Int) {
        for _ in 0...(elements - 1) {
            let dot = UIImageView(image: Image.dotUnselected)
            dots.append(dot)
        }
        
        dots.forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func select(element: Int) {
        guard dots.count > 0 else { return }
        dots.forEach {
            $0.image = Image.dotUnselected
        }
        
        dots[element].image = Image.dotSelected
    }
}

// MARK: Private methods
private extension CarouselDotsView {
    func setupView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Margin.regular.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
