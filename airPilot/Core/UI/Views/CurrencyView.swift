//
//  CurrencyPickerView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//

import UIKit

protocol CurrencyViewDelegate: AnyObject {
    func tapView()
}

class CurrencyView: UIView {
    // MARK: External properties
    weak var delegate: CurrencyViewDelegate?
    
    // MARK: Private properties
    private let label = UILabel()
    private var currency: Currency = .usd
    
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
extension CurrencyView {
    func set(currency: Currency) {
        self.currency = currency
        label.text = currency.rawValue
    }
    
    func getCurrency() -> Currency {
        return currency
    }
}

// MARK: Private methods
private extension CurrencyView {
    func setupView() {
        setupContainer()
        setupLabel()
    }
    
    func setupContainer() {
        backgroundColor = Color.gray.withFrailAlpha
        layer.cornerRadius = Constants.cornerRadius
        set(height: 44)
    }
    
    func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bigSemiBold
        label.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.regular.leading),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.regular.trailing)
        ])
    }
}
