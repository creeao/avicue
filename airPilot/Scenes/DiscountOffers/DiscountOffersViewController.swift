//
//  DiscountOffersViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol DiscountOffersDisplayable {
    func displayContent(_ viewModel: DiscountOffers.Content.ViewModel)
}

final class DiscountOffersViewController: ViewController {
    // MARK: External properties
    var interactor: DiscountOffersLogic?
    
    // MARK: Private properties
    private let headerView = UIView()
    private let headerButtonsView = UIStackView()
    private let createOfferButton = Button()
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

// MARK: DiscountOffersDisplayable
extension DiscountOffersViewController: DiscountOffersDisplayable {
    func displayContent(_ viewModel: DiscountOffers.Content.ViewModel) {
        setupCells(with: viewModel.offers)
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension DiscountOffersViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func routeToFilters() {
        let filters = Filters.createScene()
        push(filters)
    }
}

// MARK: Events
private extension DiscountOffersViewController {
    @objc func tapCreateOfferButton() {}
    
    @objc func tapFilltersButton() {}
}


// MARK: Private methods
private extension DiscountOffersViewController {
    func setupView() {
        setupHeaderView()
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

        setupHeaderButtonsView()
    }
    
    func setupHeaderButtonsView() {
        headerView.addSubview(headerButtonsView)
        headerButtonsView.translatesAutoresizingMaskIntoConstraints = false
        headerButtonsView.axis = .horizontal
        headerButtonsView.spacing = Margin.large.space
        
        NSLayoutConstraint.activate([
            headerButtonsView.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerButtonsView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: Margin.normal.trailing),
            headerButtonsView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        setupCreateOfferButton()
        setupFiltersButton()
    }
    
    func setupCreateOfferButton() {
        createOfferButton.setup(for: .image, and: Image.plus)
        createOfferButton.addTarget(self, action: #selector(tapCreateOfferButton), for: .touchUpInside)

        setupButton(createOfferButton, with: headerButtonsView)
    }
    
    func setupFiltersButton() {
        filtersButton.setup(for: .image, and: Image.filter)
        filtersButton.addTarget(self, action: #selector(tapFilltersButton), for: .touchUpInside)
        
        setupButton(filtersButton, with: headerButtonsView)
    }
    
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
    
    func setupButton(_ button: UIButton, with stackView: UIStackView) {
        stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupCells(with offers: [DiscountOfferModel]) {
        offers.forEach {
            let cell = DiscountOfferCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? DiscountOfferCell {
            let input = DiscountOffer.Input(id: selectedCell.id)
            let discountOffer = DiscountOffer.createScene(input)
            push(discountOffer)
        }
    }
}
