//
//  SelectCategoryViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol SelectCategoryDisplayable {
    func displayContent(_ viewModel: SelectCategory.Content.ViewModel)
}

final class SelectCategoryViewController: ViewController {
    // MARK: External properties
    var interactor: SelectCategoryLogic?
    
    // MARK: Private properties
    private var type: SelectCategory.CategoryType = .job

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
}

// MARK: SelectCategoryDisplayable
extension SelectCategoryViewController: SelectCategoryDisplayable {
    func displayContent(_ viewModel: SelectCategory.Content.ViewModel) {
        type = viewModel.type
        setupCells(with: viewModel.categories)
        hideLoader(reloadData: true)
    }
}

// MARK: SelectCategoryCellDelegate
extension SelectCategoryViewController: SelectCategoryCellDelegate {
    func showSubcategories(_ category: Category) {
        let categories = SelectCategory.createScene(.init(type: type, category: category))
        push(categories)
    }
    
    func selectCategory(_ category: Category) {
        switch type {
        case .job:
            if let jobOfferCreator = getViewController(type: JobOfferCreatorViewController.self) {
                (jobOfferCreator as? JobOfferCreatorViewController)?.selectCategory(category)
                pop(to: JobOfferCreatorViewController.self)
                return
            }
            
            if let jobOffers = getViewControllerFromTabBar(type: JobOffersViewController.self) {
                (jobOffers as? JobOffersViewController)?.selectCategory(category)
                pop(to: TabBarController.self)
            }
        case .shop:
            if let shopOfferCreator = getViewController(type: ShopOfferCreatorViewController.self) {
                (shopOfferCreator as? ShopOfferCreatorViewController)?.selectCategory(category)
                pop(to: ShopOfferCreatorViewController.self)
                return
            }
            
            if let shopOffers = getViewControllerFromTabBar(type: ShopOffersViewController.self) {
                (shopOffers as? ShopOffersViewController)?.selectCategory(category)
                pop(to: TabBarController.self)
            }
        }
        
//        if let shopOfferCreator = getViewController(type: ShopOfferCreatorViewController.self) {
//            (shopOfferCreator as? ShopOfferCreatorViewController)?.selectCompany(companyModel)
//            pop(to: ShopOfferCreatorViewController.self)
//        }
    }
}

// MARK: External methods
extension SelectCategoryViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension SelectCategoryViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupTitleCell()
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Select category")
        appendCell(cell)
    }
    
    func setupCells(with categories: [Category]) {
        categories.forEach {
            let cell = SelectCategoryCell()
            cell.delegate = self
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
}
