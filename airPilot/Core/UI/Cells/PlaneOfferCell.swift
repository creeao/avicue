//
//  PlaneOfferCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
////
//import UIKit
//
//class PlaneOfferCell: TableViewCell {
//    // MARK: Private properties
//    private var model: PlaneOfferModel? = nil
//    
//    private let imageContainerView = UIView()
//    private let planeImageView = UIImageView()
//    private let favouriteButton = FavouriteButton()
//    
//    private let labelsContainerView = UIView()
//    private let locationLabel = UILabel()
//    private let nameLabel = UILabel()
//    private let priceLabel = UILabel()
//
//    // MARK: Life cycle
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//}
//
//// MARK: External methods
//extension PlaneOfferCell {
//    func setup(with planeOffer: PlaneOfferModel) {
//        planeImageView.getImage(from: planeOffer.images?.first)
//        
//        let isFavourite = planeOffer.favourites.contains(Globals.userId)
//        isFavourite ? favouriteButton.setFavourite() : favouriteButton.removeFavourite()
//
//        locationLabel.text = setupLocation(with: planeOffer.location)
//        nameLabel.text = planeOffer.name
//        priceLabel.text = setupPrice(with: planeOffer.price, and: planeOffer.type)
//        model = planeOffer
//    }
//    
//    func getModel() -> PlaneOfferModel? {
//        return model
//    }
//}
//
//// MARK: Events
//private extension PlaneOfferCell {
//    @objc func tapFavouriteButton() {
//        favouriteButton.checkState() ? favouriteButton.removeFavourite() : favouriteButton.setFavourite()
//    }
//}
//
//// MARK: Private methods
//private extension PlaneOfferCell {
//    func setupView() {
//        setupImageContainerView()
//        setupLabelsContainerView()
//    }
//    
//    func setupImageContainerView() {
//        containerView.addSubview(imageContainerView)
//        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.small.top),
//            imageContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
//            imageContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.small.trailing)
//        ])
//        
//        setupApartmentImageView()
//        setupFavouriteButton()
//    }
//    
//    func setupApartmentImageView() {
//        imageContainerView.addSubview(planeImageView)
//        planeImageView.translatesAutoresizingMaskIntoConstraints = false
//        planeImageView.layer.masksToBounds = true
//        planeImageView.layer.cornerRadius = Constants.smallerCornerRadius
//        
//        NSLayoutConstraint.activate([
//            planeImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
//            planeImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
//            planeImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
//            planeImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
//            planeImageView.heightAnchor.constraint(equalToConstant: Constants.Size.photo),
//        ])
//    }
//    
//    func setupFavouriteButton() {
//        imageContainerView.addSubview(favouriteButton)
//        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
//        favouriteButton.addTarget(self, action: #selector(tapFavouriteButton), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            favouriteButton.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: Margin.small.top),
//            favouriteButton.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: Margin.small.trailing),
//            favouriteButton.heightAnchor.constraint(equalToConstant: 34),
//            favouriteButton.widthAnchor.constraint(equalToConstant: 34)
//        ])
//    }
//    
//    func setupLabelsContainerView() {
//        containerView.addSubview(labelsContainerView)
//        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            labelsContainerView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: Margin.regular.top),
//            labelsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
//            labelsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.normal.trailing),
//            labelsContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom)
//        ])
//        
//        setupLocationLabel()
//        setupNameLabel()
//        setupPriceLabel()
//    }
//    
//    func setupLocationLabel() {
//        labelsContainerView.addSubview(locationLabel)
//        locationLabel.translatesAutoresizingMaskIntoConstraints = false
//        locationLabel.font = Font.smallMedium
//        locationLabel.textColor = Color.gray
//        
//        NSLayoutConstraint.activate([
//            locationLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
//            locationLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            locationLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
//        ])
//    }
//    
//    func setupNameLabel() {
//        labelsContainerView.addSubview(nameLabel)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.textColor = Color.black
//        nameLabel.font = Font.bigSemiBold
//        
//        NSLayoutConstraint.activate([
//            nameLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Margin.mini.top),
//            nameLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            nameLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
//        ])
//    }
//    
//    func setupPriceLabel() {
//        labelsContainerView.addSubview(priceLabel)
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        priceLabel.textColor = Color.gray
//        priceLabel.font = Font.normalSemiBold
//        
//        NSLayoutConstraint.activate([
//            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.mini.top),
//            priceLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            priceLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
//        ])
//    }
//    
//    func setupLocation(with location: Location?) -> String {
//        var additionalInformation = String.empty
//        
//        if let buildingNumber = location?.buildingNumber {
//            additionalInformation += buildingNumber
//        }
//        
//        if let flatNumber = location?.flatNumber {
//            additionalInformation += (String.slash + flatNumber)
//        }
//        
//        return (location?.country?.rawValue).orEmpty + String.comma + (location?.street).orEmpty + String.space + additionalInformation
//    }
//    
//    func setupPrice(with price: Amount?, and type: PlaneOfferType?) -> String {
//        guard let price, let type else { return String.empty }
//        switch type {
//        case .rent:
//            return price.getAmount() + String.slashWithSpaces + type.getText()
//        case .sale:
//            return price.getAmount()
//        }
//    }
//}
