//
//  CurrencyListViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 21/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol CurrencyListDisplayable {
    func displayContent(_ viewModel: CurrencyList.Content.ViewModel)
}

final class CurrencyListViewController: ViewController {
    // MARK: External properties
    var interactor: CurrencyListLogic?
    
    // MARK: Private properties
    private let searchBar = TextFieldButton()
    
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

// MARK: CurrencyListDisplayable
extension CurrencyListViewController: CurrencyListDisplayable {
    func displayContent(_ viewModel: CurrencyList.Content.ViewModel) {
        setupCells(with: Currency.allCases)
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension CurrencyListViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension CurrencyListViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupSearchBar()
        setupHiddenKeyboard()
        setupTableView()
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setup(placeholder: "Search currency", buttonImage: Image.search)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.normal.top),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        tableView.contentInset = Insets.setup(top: Margin.normal.top)
        tableView.scrollIndicatorInsets = Insets.setup(top: Margin.normal.top)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCells(with currencyList: [Currency]) {
        currencyList.forEach {
            let cell = CurrencyCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? CurrencyCell {
            if let jobOfferCreator = getViewController(type: JobOfferCreatorViewController.self) {
                (jobOfferCreator as? JobOfferCreatorViewController)?.selectCurrency(selectedCell.getCurrency())
                pop(to: JobOfferCreatorViewController.self)
            }
            
            if let shopOfferCreator = getViewController(type: ShopOfferCreatorViewController.self) {
                (shopOfferCreator as? ShopOfferCreatorViewController)?.selectCurrency(selectedCell.getCurrency())
                pop(to: ShopOfferCreatorViewController.self)
            }
        }
    }
}
