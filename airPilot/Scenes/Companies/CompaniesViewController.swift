//
//  CompaniesViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol CompaniesDisplayable {
    func displayContent(_ viewModel: Companies.Content.ViewModel)
}

final class CompaniesViewController: ViewController {
    // MARK: External properties
    var interactor: CompaniesLogic?
    
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

// MARK: CompaniesDisplayable
extension CompaniesViewController: CompaniesDisplayable {
    func displayContent(_ viewModel: Companies.Content.ViewModel) {
        setupCells(with: viewModel.companies)
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension CompaniesViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension CompaniesViewController {
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
        searchBar.setup(placeholder: "Search people", buttonImage: Image.search)
        
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
    
    func setupCells(with companies: [CompanyModel]) {
        companies.forEach {
            let cell = CompanyCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? CompanyCell,
           let companyModel = selectedCell.getModel() {
            if let jobOfferCreator = getViewController(type: JobOfferCreatorViewController.self) {
                (jobOfferCreator as? JobOfferCreatorViewController)?.selectCompany(companyModel)
                pop(to: JobOfferCreatorViewController.self)
            }
            
            if let shopOfferCreator = getViewController(type: ShopOfferCreatorViewController.self) {
                (shopOfferCreator as? ShopOfferCreatorViewController)?.selectCompany(companyModel)
                pop(to: ShopOfferCreatorViewController.self)
            }
            
            if let jobHistoryCreator = getViewController(type: JobHistoryCreatorViewController.self) {
                (jobHistoryCreator as? JobHistoryCreatorViewController)?.selectCompany(companyModel)
                pop(to: JobHistoryCreatorViewController.self)
            }
            
            if let groupCreator = getViewController(type: GroupCreatorViewController.self) {
                (groupCreator as? GroupCreatorViewController)?.selectCompany(companyModel)
                pop(to: GroupCreatorViewController.self)
            }
        }
    }
}
