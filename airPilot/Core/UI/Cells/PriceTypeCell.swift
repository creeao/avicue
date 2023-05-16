//
//  PriceTypeCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/11/2022.
//

import UIKit

protocol PriceTypeCellDelegate: AnyObject {
    func tapCurrencyView()
    func tapTypeButton()
}

class PriceTypeCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: PriceTypeCellDelegate?
    
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let textField = TextField()
    private let currencyView = CurrencyView()
    private let typeButton = Button()
    private var type: ShopOfferType = .sale
    
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
extension PriceTypeCell {
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
    
    func select(_ type: ShopOfferType) {
        self.type = type
        typeButton.setTitle(type.rawValue, for: .normal)
    }
}
    
// MARK: Events
private extension PriceTypeCell {
    @objc func tapCurrencyView() {
        delegate?.tapCurrencyView()
    }
    
    @objc func tapTypeButton() {
        delegate?.tapTypeButton()
    }
}

// MARK: Private methods
private extension PriceTypeCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupTextField()
        setupCurrencyView()
        setupTypeButton()
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
            currencyView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupTypeButton() {
        containerView.addSubview(typeButton)
        typeButton.translatesAutoresizingMaskIntoConstraints = false
        typeButton.setup(for: .selector, with: ShopOfferType.sale.rawValue)
        typeButton.addTarget(self, action: #selector(tapTypeButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            typeButton.topAnchor.constraint(equalTo: currencyView.topAnchor),
            typeButton.leadingAnchor.constraint(equalTo: currencyView.trailingAnchor, constant: Margin.medium.leading),
            typeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            typeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            typeButton.widthAnchor.constraint(equalToConstant: 130),
            typeButton.heightAnchor.constraint(equalToConstant: Constants.Size.listElement)
        ])
    }
    
//    func setupTypeButton() {
//        containerView.addSubview(currencyView)
//        currencyView.translatesAutoresizingMaskIntoConstraints = false
//
//        let action = UITapGestureRecognizer(target: self, action: #selector(tapCurrencyView))
//        currencyView.addGestureRecognizer(action)
//        currencyView.isUserInteractionEnabled = true
//
//        NSLayoutConstraint.activate([
//            currencyView.topAnchor.constraint(equalTo: textField.topAnchor),
//            currencyView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Margin.medium.leading),
//            currencyView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            currencyView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//        ])
//    }
}
