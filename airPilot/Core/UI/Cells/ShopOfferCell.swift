//
//  ShopShopOfferCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//

import UIKit

protocol ShopOfferCellDelegate: AnyObject {
    func tapFavouriteButton(offerId: Int, isFavourite: Bool)
    func tapShopOfferCell(id: Int)
}

class ShopOfferCell: TableViewCell {
    // MARK: External properties
    weak var delegate: ShopOfferCellDelegate?
    
    // MARK: Private properties
    private let imageContainerView = UIView()
    private let offerImageView = UIImageView()
    private let favouriteButton = FavouriteButton()
    
    private let labelsContainerView = UIStackView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
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
extension ShopOfferCell {
    func setup(with offerModel: ShopOfferModel, inCompany: Bool = false) {
        id = offerModel.id

        offerImageView.getImage(from: offerModel.images?.first)
        offerModel.isFavourite.isTrue ? favouriteButton.setFavourite() : favouriteButton.removeFavourite()
        
        if offerModel.category?.name?.lowercased() == ShopOfferMainCategory.apartments.path {
            setupApartmentView(with: offerModel)
        } else {
            setupView(with: offerModel)
        }

        if offerModel.rating.isNil {
            ratingView.isHidden = true
        }
        
        if inCompany {
            setupForCompany()
        }
    }
}

// MARK: Events
private extension ShopOfferCell {
    @objc func tapFavouriteButton() {
        favouriteButton.checkState() ? favouriteButton.removeFavourite() : favouriteButton.setFavourite()
        delegate?.tapFavouriteButton(offerId: id, isFavourite: favouriteButton.checkState())
    }
    
    @objc func tapShopOfferCell() {
        delegate?.tapShopOfferCell(id: id)
    }
}

// MARK: Private methods
private extension ShopOfferCell {
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
        containerView.addSubview(labelsContainerView)
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        labelsContainerView.axis = .vertical
        labelsContainerView.spacing = Margin.mini.space
        
        NSLayoutConstraint.activate([
            labelsContainerView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: Margin.regular.top),
            labelsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
            labelsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Margin.normal.trailing),
            labelsContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.normal.bottom)
        ])
    }
    
    
    func setupFirstLabel() {
        labelsContainerView.addArrangedSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.font = Font.smallMedium
        firstLabel.textColor = Color.gray

//        NSLayoutConstraint.activate([
//            firstLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
//            firstLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            firstLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
//        ])
    }

    func setupSecondLabel() {
        labelsContainerView.addArrangedSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.textColor = Color.black
        secondLabel.font = Font.bigSemiBold

//        NSLayoutConstraint.activate([
//            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: Margin.mini.top),
//            secondLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            secondLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
//        ])
    }

    func setupThirdLabel() {
        labelsContainerView.addArrangedSubview(thirdLabel)
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.textColor = Color.gray
        thirdLabel.font = Font.normalSemiBold

//        NSLayoutConstraint.activate([
//            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: Margin.mini.top),
//            thirdLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
//            thirdLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
//        ])
    }
    
    func setupRatingView() {
        labelsContainerView.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
            ratingView.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
        ])
    }
    
    func setupLocation(with offerModel: ShopOfferModel?) -> String {
        var location = String.empty
        
        if let country = offerModel?.country {
            location += country
        }
        
        if let city = offerModel?.city {
            location += (String.comma + city)
        }
        
        if let buildingNumber = offerModel?.buildingNumber {
            location += (String.space + buildingNumber)
        }
        
        if let flatNumber = offerModel?.apartmentNumber {
            location += (String.slash + flatNumber)
        }
        
        return location
    }
    
    func setupPrice(with offerModel: ShopOfferModel) -> String {
        guard let price = offerModel.price, let currency = offerModel.currency, let type = offerModel.type else {
            return String.empty
        }
        
        return price.getAmount(with: currency) + type.getText()
    }
    
    func setupView(with offerModel: ShopOfferModel) {
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
        
        firstLabel.text = setupLocation(with: offerModel)
        secondLabel.text = offerModel.name
        thirdLabel.text = setupPrice(with: offerModel)
    }
    
    func setupApartmentView(with offerModel: ShopOfferModel) {
        setupSecondLabel()
        setupThirdLabel()
        
        secondLabel.text = setupLocation(with: offerModel)
        thirdLabel.text = setupPrice(with: offerModel)
        ratingView.setup(rating: offerModel.rating)
    }
    
    func setupForCompany() {
        let action = UITapGestureRecognizer(target: self, action: #selector(tapShopOfferCell))
        contentView.addGestureRecognizer(action)
        contentView.isUserInteractionEnabled = true
    }
}

