//
//  DiscountOfferCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//

import UIKit

class DiscountOfferCell: TableViewCell {
    // MARK: Private properties
    private let imageContainerView = UIView()
    private let offerImageView = UIImageView()
    
    private let labelsContainerView = UIView()
    private let locationLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let ratingView = RatingView()

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
extension DiscountOfferCell {
    func setup(with offerModel: DiscountOfferModel) {
        id = offerModel.id

        offerImageView.getImage(from: offerModel.images?.first)

//        locationLabel.text = setupLocation(with: offerModel.location)
//        priceLabel.text = setupPrice(with: offerModel.price, and: offerModel.type)
//        ratingView.setup(rating: offerModel.rating)
        
        if offerModel.rating.isNil {
            ratingView.isHidden = true
        }
    }
}

// MARK: Private methods
private extension DiscountOfferCell {
    func setupView() {
        setupImageContainerView()
        setupLabelsContainerView()
    }
    
    func setupImageContainerView() {
        containerView.addSubview(imageContainerView)
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.small.top),
            imageContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            imageContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.small.trailing)
        ])
        
        setupOfferImageView()
    }
    
    func setupOfferImageView() {
        imageContainerView.addSubview(offerImageView)
        offerImageView.translatesAutoresizingMaskIntoConstraints = false
        offerImageView.layer.masksToBounds = true
        offerImageView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            offerImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            offerImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            offerImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            offerImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            offerImageView.heightAnchor.constraint(equalToConstant: Constants.Size.photo),
        ])
    }
    
    func setupLabelsContainerView() {
        containerView.addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelsContainerView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: Margin.regular.top),
            labelsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.normal.trailing),
            labelsContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom)
        ])
        
        setupLocationLabel()
        setupPriceLabel()
        setupRatingView()
    }
    
    func setupLocationLabel() {
        labelsContainerView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textColor = Color.black
        locationLabel.font = Font.bigSemiBold
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
        ])
    }
    
    func setupPriceLabel() {
        labelsContainerView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = Color.gray
        priceLabel.font = Font.normalSemiBold
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Margin.mini.top),
            priceLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
        ])
    }
    
    func setupRatingView() {
        labelsContainerView.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            ratingView.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
        ])
    }
    
    func setupLocation(with location: Location?) -> String {
        var additionalInformation = String.empty
        
        if let buildingNumber = location?.buildingNumber {
            additionalInformation += buildingNumber
        }
        
        if let flatNumber = location?.flatNumber {
            additionalInformation += (String.slash + flatNumber)
        }
        
        return (location?.country?.rawValue).orEmpty + String.comma + (location?.street).orEmpty + String.space + additionalInformation
    }
    
    func setupPrice(with price: Amount?, and type: ShopOfferType?) -> String {
        guard let price, let type else { return String.empty }
        return price.getAmount() + type.getText()
    }
}

