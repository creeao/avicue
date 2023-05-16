//
//  SalaryRangeCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//

import UIKit

protocol SalaryRangeCellDelegate: AnyObject {
    func tapCurrencyView()
}

class SalaryRangeCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: SalaryRangeCellDelegate?
    
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let minTextField = TextField()
    private let iconView = UIImageView()
    private let maxTextField = TextField()
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
extension SalaryRangeCell {
    func setup(with title: String, and currency: Currency) {
        titleLabel.text = title
        minTextField.setupPlaceholder("0,0", aligment: .left, height: Constants.Size.textField)
        maxTextField.setupPlaceholder("0,0", aligment: .left, height: Constants.Size.textField)
        currencyView.set(currency: currency)
    }
    
    func select(_ currency: Currency) {
        currencyView.set(currency: currency)
    }
    
    func getMinSalary() -> String? {
        return minTextField.text
    }
    
    func getMaxSalary() -> String? {
        return maxTextField.text
    }
    
    func getCurrency() -> Currency {
        return currencyView.getCurrency()
    }
}
    
// MARK: Events
private extension SalaryRangeCell {
    @objc func tapCurrencyView() {
        delegate?.tapCurrencyView()
    }
}

// MARK: Private methods
private extension SalaryRangeCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupMinTextField()
        setupIconView()
        setupMaxTextField()
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
    
    func setupMinTextField() {
        containerView.addSubview(minTextField)
        minTextField.translatesAutoresizingMaskIntoConstraints = false
        minTextField.keyboardType = .decimalPad
        
        NSLayoutConstraint.activate([
            minTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            minTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            minTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            minTextField.widthAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    func setupIconView() {
        containerView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = Image.money
        iconView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: minTextField.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: minTextField.trailingAnchor, constant: Margin.medium.leading),
        ])
    }
    
    func setupMaxTextField() {
        containerView.addSubview(maxTextField)
        maxTextField.translatesAutoresizingMaskIntoConstraints = false
        maxTextField.keyboardType = .decimalPad
        
        NSLayoutConstraint.activate([
            maxTextField.topAnchor.constraint(equalTo: minTextField.topAnchor),
            maxTextField.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Margin.medium.leading),
            maxTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            maxTextField.widthAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    func setupCurrencyView() {
        containerView.addSubview(currencyView)
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapCurrencyView))
        currencyView.addGestureRecognizer(action)
        currencyView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            currencyView.topAnchor.constraint(equalTo: maxTextField.topAnchor),
            currencyView.leadingAnchor.constraint(equalTo: maxTextField.trailingAnchor, constant: Margin.medium.leading),
            currencyView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
