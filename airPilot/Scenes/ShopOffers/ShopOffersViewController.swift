//
//  ShopOffersViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol ShopOffersDisplayable {
    func displayContent(_ viewModel: ShopOffers.Content.ViewModel)
}

final class ShopOffersViewController: ViewController {
    // MARK: External properties
    var interactor: ShopOffersLogic?
    
    // MARK: Private properties
    private let headerView = UIView()
    private let createOfferButton = Button()
    private let favouritesButton = Button()
    private let filtersButton = Button()
    private let separatorView = UIView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func setupSelectionCell(for index: IndexPath) {
        setupSelection(for: index)
    }
}

// MARK: ShopOffersDisplayable
extension ShopOffersViewController: ShopOffersDisplayable {
    func displayContent(_ viewModel: ShopOffers.Content.ViewModel) {
        removeCells()
        setupCells(with: viewModel.offers)
        hideLoader(reloadData: true)
    }
}

//// MARK: CategoriesSliderDelegate
//extension ShopOffersViewController: CategoriesSliderDelegate {
//    func tapCategory(_ category: Category) {
//        interactor?.getContent(.init(category: category))
//    }
//}

// MARK: ShopOfferCellDelegate
extension ShopOffersViewController: ShopOfferCellDelegate {
    func tapFavouriteButton(offerId: Int, isFavourite: Bool) {
        interactor?.tapFavouriteButton(.init(offerId: offerId, isFavourite: isFavourite))
    }
    
    func tapShopOfferCell(id: Int) {}
}

// MARK: Events
extension ShopOffersViewController {
    @objc func tapCreateOfferButton() {
        let createOffer = ShopOfferCreator.createScene()
        push(createOffer)
    }
    
    @objc func tapFavouritesButton() {
        let input = Favourites.Input(type: .shopOffers)
        let favourites = Favourites.createScene(input)
        push(favourites)
    }
    
    @objc func tapFilltersButton() {
        let categories = SelectCategory.createScene(.init(type: .shop, category: nil))
        push(categories)
//        let filter = Filters.createScene()
//        push(filter)
    }
}

// MARK: External methods
extension ShopOffersViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init(category: nil))
    }
    
//    func routeToFilters() {
//        let filters = Filters.createScene()
//        push(filters)
//    }
    
    func selectCategory(_ category: Category) {
        interactor?.getContent(.init(category: category))
//        interactor?.selectCategory(.init(category: category))
//        let companyCell = getCell(Tag.categoryCell) as? TextFieldTitleLogoButtonCell
//        companyCell?.select(with: model)
    }
}

// MARK: Private methods
private extension ShopOffersViewController {
    func setupView() {
        setupHeaderView()
//        setupCategoriesSlider()
        setupSeparatorView()
        setupTableView()
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.normal.top),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing)
        ])
        
        setupCreateOfferButton()
        setupFiltersButton()
        setupFavouritesButton()
    }
    
    func setupCreateOfferButton() {
        headerView.addSubview(createOfferButton)
        createOfferButton.translatesAutoresizingMaskIntoConstraints = false
        
        createOfferButton.setup(for: .image, and: Image.plus)
        createOfferButton.addTarget(self, action: #selector(tapCreateOfferButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            createOfferButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            createOfferButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Margin.normal.leading),
            createOfferButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    func setupFavouritesButton() {
        headerView.addSubview(favouritesButton)
        favouritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        favouritesButton.setup(for: .image, and: Image.heartBordered)
        favouritesButton.addTarget(self, action: #selector(tapFavouritesButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            favouritesButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            favouritesButton.trailingAnchor.constraint(equalTo: filtersButton.leadingAnchor, constant: Margin.big.trailing),
            favouritesButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    func setupFiltersButton() {
        headerView.addSubview(filtersButton)
        filtersButton.translatesAutoresizingMaskIntoConstraints = false
        
        filtersButton.setup(for: .image, and: Image.filter)
        filtersButton.addTarget(self, action: #selector(tapFilltersButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            filtersButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            filtersButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: Margin.normal.trailing),
            filtersButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
//    func setupCategoriesSlider() {
//        view.addSubview(categoriesSlider)
//        categoriesSlider.translatesAutoresizingMaskIntoConstraints = false
//
//        categoriesSlider.setup([
//            CategoryViewModel(
//                image: Image.Categories.all,
//                category: .init(
//                    id: 0,
//                    name: ShopOfferMainCategory.all.name,
//                    path: ShopOfferMainCategory.all.path,
//                    categories: nil)),
//            CategoryViewModel(
//                image: Image.Categories.aviation,
//                category: .init(
//                    id: 0,
//                    name: ShopOfferMainCategory.aviation.name,
//                    path: ShopOfferMainCategory.aviation.path,
//                    categories: nil)),
//            CategoryViewModel(
//                image: Image.Categories.apartments,
//                category: .init(
//                    id: 0,
//                    name: ShopOfferMainCategory.apartments.name,
//                    path: ShopOfferMainCategory.apartments.path,
//                    categories: nil)),
//            CategoryViewModel(
//                image: Image.Categories.other,
//                category: .init(
//                    id: 0,
//                    name: ShopOfferMainCategory.others.name,
//                    path: ShopOfferMainCategory.others.path,
//                    categories: nil))
//        ])
//
//        categoriesSlider.delegate = self
//
//        NSLayoutConstraint.activate([
//            categoriesSlider.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Margin.regular.top),
//            categoriesSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            categoriesSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            categoriesSlider.heightAnchor.constraint(equalToConstant: 80)
//        ])
//    }
    
    func setupSeparatorView() {
        view.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Color.gray.withFrailAlpha

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Margin.normal.top),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        
        tableView.contentInset = Insets.setup(top: Margin.small.top)
        tableView.scrollIndicatorInsets = Insets.setup(top: Margin.small.top)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCells(with offers: [ShopOfferModel]) {
        offers.forEach {
            let cell = ShopOfferCell()
            cell.delegate = self
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? ShopOfferCell {
            let input = ShopOffer.Input(id: selectedCell.id)
            let shopOffer = ShopOffer.createScene(input)
            push(shopOffer)
        }
    }
}
