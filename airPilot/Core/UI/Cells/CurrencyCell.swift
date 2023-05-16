//
//  CurrencyCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//

import UIKit

final class CurrencyCell: TableViewCell {
    // MARK: Private properties
    private var currency: Currency = .usd
    private let currencyView = CurrencyView()
    private let currencyLabel = UILabel()
    
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
extension CurrencyCell {
    func setup(with currency: Currency) {
        self.currency = currency
        currencyView.set(currency: currency)
        currencyLabel.text = currency.name
    }
    
    func getCurrency() -> Currency {
        return currency
    }
}
    
// MARK: Private methods
private extension CurrencyCell {
    func setupView() {
        setupCurrencyView()
        setupCurrencyLabel()
    }
    
    func setupCurrencyView() {
        containerView.addSubview(currencyView)
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        currencyView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            currencyView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.small.top),
            currencyView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            currencyView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.small.bottom),
        ])
    }
    
    func setupCurrencyLabel() {
        containerView.addSubview(currencyLabel)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.font = Font.normalSemiBold
        currencyLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            currencyLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: currencyView.trailingAnchor, constant: Margin.medium.leading),
        ])
    }
}
