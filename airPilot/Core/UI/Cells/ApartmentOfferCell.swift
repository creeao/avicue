//
//  ApartmentOfferCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
////
//import UIKit
//
//class ApartmentOfferCell: TableViewCell {
//    // MARK: Private properties
//    private var model: ApartmentOfferModel? = nil
//    
//    private let imageContainerView = UIView()
//    private let apartmentImageView = UIImageView()
//    private let favouriteButton = FavouriteButton()
//    
//    private let labelsContainerView = UIView()
//    private let locationLabel = UILabel()
//    private let priceLabel = UILabel()
//    private let ratingView = RatingView()
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
//extension ApartmentOfferCell {
//    func setup(with apartmentOffer: ApartmentOfferModel) {
//        if let mainPhoto = apartmentOffer.images?.first {
//            apartmentImageView.getImage(from: mainPhoto)
//        }
//        
//        let isFavourite = apartmentOffer.favourites.contains(Globals.userId)
//        isFavourite ? favouriteButton.setFavourite() : favouriteButton.removeFavourite()
//
//        locationLabel.text = setupLocation(with: apartmentOffer.location)
//        priceLabel.text = setupPrice(with: apartmentOffer.price, and: apartmentOffer.type)
//        
//        ratingView.setup(ratingList: apartmentOffer.ratingList)
//        model = apartmentOffer
//    }
//    
//    func getModel() -> ApartmentOfferModel? {
//        return model
//    }
//}
//
//// MARK: Events
//private extension ApartmentOfferCell {
//    @objc func tapFavouriteButton() {
//        favouriteButton.checkState() ? favouriteButton.removeFavourite() : favouriteButton.setFavourite()
//    }
//}
//
//// MARK: Private methods
//private extension ApartmentOfferCell {
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
//        imageContainerView.addSubview(apartmentImageView)
//        apartmentImageView.translatesAutoresizingMaskIntoConstraints = false
//        apartmentImageView.layer.masksToBounds = true
//        apartmentImageView.layer.cornerRadius = Constants.smallerCornerRadius
//        
//        NSLayoutConstraint.activate([
//            apartmentImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
//            apartmentImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
//            apartmentImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
//            apartmentImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
//            apartmentImageView.heightAnchor.constraint(equalToConstant: Constants.Size.photo),
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
//        setupPriceLabel()
//        setupRatingView()
//    }
//    
//    func setupLocationLabel() {
//        labelsContainerView.addSubview(locationLabel)
//        locationLabel.translatesAutoresizingMaskIntoConstraints = false
//        locationLabel.textColor = Color.black
//        locationLabel.font = Font.bigSemiBold
//        
//        NSLayoutConstraint.activate([
//            locationLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
//            locationLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
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
//            priceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Margin.mini.top),
//            priceLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            priceLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
//        ])
//    }
//    
//    func setupRatingView() {
//        labelsContainerView.addSubview(ratingView)
//        ratingView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            ratingView.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
//            ratingView.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
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
//    func setupPrice(with price: Amount?, and type: ApartmentOfferType?) -> String {
//        guard let price, let type else { return String.empty }
//        switch type {
//        case .daily:
//            return price.getAmount() + String.slashWithSpaces + "24H"
//        case .monthly:
//            return price.getAmount() + String.slashWithSpaces + "MONTHLY"
//        }
//    }
//}
