//
//  PriceCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 23/11/2022.
//

import UIKit

protocol PriceCellDelegate: AnyObject {
    func tapCurrencyView()
}

class PriceCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: PriceCellDelegate?
    
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let textField = TextField()
    private let currencyView = CurrencyView()
    
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
extension PriceCell {
    func setup(with title: String, and currency: Currency) {
        titleLabel.text = title
        textField.setupPlaceholder("0,0", aligment: .left, height: Constants.Size.textField)
        currencyView.set(currency: currency)
    }
    
    func select(_ currency: Currency) {
        currencyView.set(currency: currency)
    }
    
    func getPrice() -> String? {
        return textField.text
    }

    func getCurrency() -> Currency {
        return currencyView.getCurrency()
    }
}
    
// MARK: Events
private extension PriceCell {
    @objc func tapCurrencyView() {
        delegate?.tapCurrencyView()
    }
}

// MARK: Private methods
private extension PriceCell {
    func setupView() {
        setupContainerView(horiztonalMargin: .zero)
        setupTitleLabel()
        setupTextField()
        setupCurrencyView()
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.miniMedium
        titleLabel.textColor = Color.gray.withHardAlpha
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func setupTextField() {
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    func setupCurrencyView() {
        containerView.addSubview(currencyView)
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapCurrencyView))
        currencyView.addGestureRecognizer(action)
        currencyView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            currencyView.topAnchor.constraint(equalTo: textField.topAnchor),
            currencyView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Margin.medium.leading),
            currencyView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            currencyView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
