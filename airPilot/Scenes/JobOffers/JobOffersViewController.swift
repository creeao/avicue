//
//  JobOffersViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol JobOffersDisplayable {
    func displayContent(_ viewModel: JobOffers.Content.ViewModel)
}

final class JobOffersViewController: ViewController {
    // MARK: External properties
    var interactor: JobOffersLogic?
    
    // MARK: Private properties
    private let headerView = UIView()
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

// MARK: JobOffersDisplayable
extension JobOffersViewController: JobOffersDisplayable {
    func displayContent(_ viewModel: JobOffers.Content.ViewModel) {
        removeCells()
        setupCells(with: viewModel.offers)
        hideLoader(reloadData: true)
    }
}

// MARK: Events
extension JobOffersViewController {
    @objc func tapCreateOfferButton() {
        let createOffer = JobOfferCreator.createScene()
        push(createOffer)
    }
    
    @objc func tapFilltersButton() {
        let input = SelectCategory.Input(type: .job, category: nil)
        let categories = SelectCategory.createScene(input)
        push(categories)
        
//        let filter = Filters.createScene()
//        push(filter)
    }
}

// MARK: External methods
extension JobOffersViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init(category: nil))
    }
    
    func selectCategory(_ category: Category) {
        interactor?.getContent(.init(category: category))
    }
    
    func routeToFilters() {
        let filters = Filters.createScene()
        push(filters)
    }
}

// MARK: Private methods
private extension JobOffersViewController {
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

        setupCreateOfferButton()
        setupFiltersButton()
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
        setupInsets(top: .small)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCells(with offers: [JobOfferModel]) {
        offers.forEach {
            let cell = JobOfferCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? JobOfferCell {
            let input = JobOffer.Input(id: selectedCell.id)
            let jobOffer = JobOffer.createScene(input)
            push(jobOffer)
        }
    }
}
