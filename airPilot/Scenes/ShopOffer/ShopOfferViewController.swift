//
//  ShopOfferViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol ShopOfferDisplayable {
    func displayContent(_ viewModel: ShopOffer.Content.ViewModel)
}

final class ShopOfferViewController: ViewController {
    // MARK: External properties
    var interactor: ShopOfferLogic?
    
    // MARK: Private properties
    private var favouriteBarButton = FavouriteBarButton()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: ShopOfferDisplayable
extension ShopOfferViewController: ShopOfferDisplayable {
    func displayContent(_ viewModel: ShopOffer.Content.ViewModel) {
        viewModel.offer.isFavourite.isTrue ? favouriteBarButton.setFavourite() : favouriteBarButton.setUnfavourite()
        setupCell(with: viewModel.offer.images)
        setupCell(with: viewModel.informations)
        setupCell(with: viewModel.offer.text)
        hideLoader(reloadData: true)
    }
}

// MARK: FavouriteBarButtonDelegate
extension ShopOfferViewController: FavouriteBarButtonDelegate {
    func setFavourite() {
        interactor?.tapFavouriteButton(.init(isFavourite: true))
    }
    
    func setUnfavourite() {
        interactor?.tapFavouriteButton(.init(isFavourite: false))
    }
}

// MARK: External methods
extension ShopOfferViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension ShopOfferViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupFavouriteButton()
        setupTableView(for: self)
        setupButton("Send message")
    }
    
    func setupFavouriteButton() {
        setupRightButton(favouriteBarButton)
        favouriteBarButton.setupView()
        favouriteBarButton.delegate = self
    }
    
    func setupCell(with images: [String]?) {
        let cell = CarouselImageCell()
        cell.setup(with: images)
        appendCell(cell)
    }
    
    func setupCell(with informations: [InformationModel]) {
        let cell = InformationsCell()
        cell.setup(with: informations)
        appendCell(cell)
    }
    
    func setupCell(with description: String?) {
        let cell = DescriptionCell()
        cell.setup(with: description)
        appendCell(cell)
    }
}
