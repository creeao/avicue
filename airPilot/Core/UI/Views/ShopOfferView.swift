//
//  ShopOfferView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 03/12/2022.
//

import UIKit

protocol ShopOfferViewDelegate: AnyObject {
    func tapShopOffer(offerId: Int)
}

final class ShopOfferView: UIView {
    // MARK: External properties
    weak var delegate: ShopOfferViewDelegate?
    
    // MARK: Private properties
    private let imageContainerView = UIView()
    private let offerImageView = UIImageView()
    private let favouriteButton = FavouriteButton()
    
    private let labelsContainerView = UIStackView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    private let ratingView = RatingView()
    
    private var offerId: Int = 0
    
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
extension ShopOfferView {
    func setup(with offer: ShopOfferModel) {
        offerId = offer.id

        offerImageView.getImage(from: offer.images?.first)
        
        let isFavourite = offer.addedToFavoritesBy.contains(Globals.userUuid)
        isFavourite ? favouriteButton.setFavourite() : favouriteButton.removeFavourite()
        
        if offer.category?.name?.lowercased() == ShopOfferMainCategory.apartments.path {
            setupApartmentView(with: offer)
        } else {
            setupView(with: offer)
        }

        if offer.rating.isNil {
            ratingView.isHidden = true
        }
    }
}

// MARK: Events
private extension ShopOfferView {
    @objc func tapShopOfferView() {
        delegate?.tapShopOffer(offerId: offerId)
    }
    
    @objc func tapFavouriteButton() {
        favouriteButton.checkState() ? favouriteButton.removeFavourite() : favouriteButton.setFavourite()
    }
}

// MARK: Private methods
private extension ShopOfferView {
    func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Color.white
        
        setupImageContainerView()
        setupLabelsContainerView()
        setupGesture()
    }
    
    func setupImageContainerView() {
        addSubview(imageContainerView)
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.small.top),
            imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.small.leading),
            imageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.small.trailing)
        ])
        
        setupOfferImageView()
        setupFavouriteButton()
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
    
    func setupFavouriteButton() {
        imageContainerView.addSubview(favouriteButton)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.addTarget(self, action: #selector(tapFavouriteButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: Margin.small.top),
            favouriteButton.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: Margin.small.trailing),
            favouriteButton.heightAnchor.constraint(equalToConstant: 34),
            favouriteButton.widthAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    func setupLabelsContainerView() {
        addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        labelsContainerView.axis = .vertical
        labelsContainerView.spacing = Margin.mini.space
        
        NSLayoutConstraint.activate([
            labelsContainerView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: Margin.regular.top),
            labelsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.normal.trailing),
            labelsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.normal.bottom)
        ])
    }
    
    
    func setupFirstLabel() {
        labelsContainerView.addArrangedSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.font = Font.smallMedium
        firstLabel.textColor = Color.gray
    }
    
    func setupSecondLabel() {
        labelsContainerView.addArrangedSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.textColor = Color.black
        secondLabel.font = Font.bigSemiBold
    }
    
    func setupThirdLabel() {
        labelsContainerView.addArrangedSubview(thirdLabel)
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.textColor = Color.gray
        thirdLabel.font = Font.normalSemiBold
    }
    
    func setupRatingView() {
        labelsContainerView.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            ratingView.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
        ])
    }
    
    func setupLocation(with offer: ShopOfferModel?) -> String {
        var location = String.empty
        
        if let country = offer?.country {
            location += country
        }
        
        if let city = offer?.city {
            location += (String.comma + city)
        }
        
        if let buildingNumber = offer?.buildingNumber {
            location += (String.space + buildingNumber)
        }
        
        if let flatNumber = offer?.apartmentNumber {
            location += (String.slash + flatNumber)
        }
        
        return location
    }
    
    func setupPrice(with offer: ShopOfferModel) -> String {
        guard let price = offer.price, let currency = offer.currency, let type = offer.type else {
            return String.empty
        }
        
        return price.getAmount(with: currency) + type.getText()
    }
    
    func setupView(with offer: ShopOfferModel) {
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
        
        firstLabel.text = setupLocation(with: offer)
        secondLabel.text = offer.name
        thirdLabel.text = setupPrice(with: offer)
    }
    
    func setupApartmentView(with offer: ShopOfferModel) {
        setupSecondLabel()
        setupThirdLabel()
        
        secondLabel.text = setupLocation(with: offer)
        thirdLabel.text = setupPrice(with: offer)
        ratingView.setup(rating: offer.rating)
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(
            target: self,
            action: #selector(tapShopOfferView))
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
}
