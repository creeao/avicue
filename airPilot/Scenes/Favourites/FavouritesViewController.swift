//
//  FavouritesViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol FavouritesDisplayable {
    func displayContent(_ viewModel: Favourites.Content.ViewModel)
}

final class FavouritesViewController: ViewController {
    // MARK: External properties
    var interactor: FavouritesLogic?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    override func setupSelectionCell(for index: IndexPath) {
        setupSelection(for: index)
    }
}

// MARK: FavouritesDisplayable
extension FavouritesViewController: FavouritesDisplayable {
    func displayContent(_ viewModel: Favourites.Content.ViewModel) {
//        setupCells(with: viewModel.planes)
//        setupCells(with: viewModel.apartments)
        setupCells(with: viewModel.shopOffers)
        hideLoader(reloadData: true)
    }
}

// MARK: ShopOfferCellDelegate
extension FavouritesViewController: ShopOfferCellDelegate {
    func tapFavouriteButton(offerId: Int, isFavourite: Bool) {
        interactor?.tapFavouriteButton(.init(offerId: offerId, isFavourite: isFavourite))
    }
    
    func tapShopOfferCell(id: Int) {}
}

// MARK: External methods
extension FavouritesViewController {
    func getContent() {
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension FavouritesViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupTitle()
    }
    
    func setupTitle() {
        let titleCell = LargeTitleCell()
        titleCell.setup(with: "Favourites")
        appendCell(titleCell)
    }
    
    func setupCells(with offers: [ShopOfferModel]) {
        offers.forEach {
            let cell = ShopOfferCell()
            cell.delegate = self
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
//    func setupCells(with planes: [PlaneOfferModel]) {
//        planes.forEach {
//            let cell = PlaneOfferCell()
//            cell.setup(with: $0)
//            appendCell(cell)
//        }
//    }
//
//    func setupCells(with apartments: [ApartmentOfferModel]) {
//        apartments.forEach {
//            let cell = ApartmentOfferCell()
//            cell.setup(with: $0)
//            appendCell(cell)
//        }
//    }
//
//    func setupSelection(for index: IndexPath) {
//        if let selectedCell = getCell(index) as? PlaneOfferCell,
//           let planeModel = selectedCell.getModel() {
//            let input = Plane.Input(planeModel: planeModel)
//            let plane = Plane.createScene(input)
//            push(plane)
//        }
//
//        if let selectedCell = getCell(index) as? ApartmentOfferCell,
//           let apartmentModel = selectedCell.getModel() {
//            let input = Apartment.Input(apartmentModel: apartmentModel)
//            let apartment = Apartment.createScene(input)
//            push(apartment)
//        }
//    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? ShopOfferCell {
            let input = ShopOffer.Input(id: selectedCell.id)
            let shopOffer = ShopOffer.createScene(input)
            push(shopOffer)
        }
    }
}
