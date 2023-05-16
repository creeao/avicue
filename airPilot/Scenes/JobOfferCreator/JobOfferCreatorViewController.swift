//
//  JobOfferCreatorViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol JobOfferCreatorDisplayable {
    func displayContent(_ viewModel: JobOfferCreator.Content.ViewModel)
    func displayResult(_ response: JobOfferCreator.Result.ViewModel)
}

final class JobOfferCreatorViewController: ViewController {
    // MARK: External properties
    var interactor: JobOfferCreatorLogic?
    
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
    
    override func setupActionButton() {
        createOffer()
    }
}

// MARK: JobOfferCreatorDisplayable
extension JobOfferCreatorViewController: JobOfferCreatorDisplayable {
    func displayContent(_ viewModel: JobOfferCreator.Content.ViewModel) {
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: JobOfferCreator.Result.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            (self?.getViewControllerFromTabBar(type: JobOffersViewController.self) as? JobOffersViewController)?.getContent()
            self?.pop(to: TabBarController.self)
        }
    }
}

// MARK: TextFieldTitleButtonCellDelegate
extension JobOfferCreatorViewController: TextFieldTitleButtonCellDelegate {
    func tapTextFieldTitleButtonCell() {
        let categories = SelectCategory.createScene(.init(type: .job, category: nil))
        push(categories)
    }
}

// MARK: TextFieldTitleLogoButtonCellDelegate
extension JobOfferCreatorViewController: TextFieldTitleLogoButtonCellDelegate {
    func tapView() {
        let companies = Companies.createScene()
        push(companies)
    }
}

// MARK: SalaryRangeCellDelegate
extension JobOfferCreatorViewController: SalaryRangeCellDelegate {
    func tapCurrencyView() {
        let currencyList = CurrencyList.createScene()
        push(currencyList)
    }
}

// MARK: External methods
extension JobOfferCreatorViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func selectCompany(_ model: CompanyModel) {
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        companyCell?.select(with: model)
    }
    
    func selectCategory(_ model: Category) {
        let categoryCell = getCell(Tag.categoryCell) as? TextFieldTitleButtonCell
        categoryCell?.select(with: model)
    }
    
    func selectCurrency(_ currency: Currency) {
        let salaryRangeCell = getCell(Tag.salaryRangeCell) as? SalaryRangeCell
        salaryRangeCell?.select(currency)
    }
    
    func createOffer() {
        let positionCell = getCell(Tag.positionCell) as? TextFieldTitleCell
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        let categoryCell = getCell(Tag.categoryCell) as? TextFieldTitleButtonCell
        let salaryRangeCell = getCell(Tag.salaryRangeCell) as? SalaryRangeCell
        let descriptionCell = getCell(Tag.descriptionCell) as? TextViewTitleCell
        
        interactor?.createOffer(.init(
            position: (positionCell?.getText()).orEmpty,
            category: (categoryCell?.id).orZero,
            minSalary: salaryRangeCell?.getMinSalary(),
            maxSalary: salaryRangeCell?.getMaxSalary(),
            currency: salaryRangeCell?.getCurrency(),
            text: (descriptionCell?.getText()).orEmpty,
            assignedTo: companyCell?.id))
    }
}

// MARK: Private methods
private extension JobOfferCreatorViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        
        setupTitleCell()
        setupPositionCell()
        setupCompanyCell()
        setupCategoryCell()
        setupSalaryRangeCell()
        setupDescriptionCell()
        setupButton("Create offer")
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Add job offer", toLeft: true)
        appendCell(cell)
    }
    
    func setupPositionCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Title", and: "e.g. First Officer B737")
        cell.identifier = Tag.positionCell
        appendCell(cell)
    }
    
    func setupCompanyCell() {
        let cell = TextFieldTitleLogoButtonCell()
        cell.setup(with: "Assigned to company", and: "Select company")
        cell.identifier = Tag.companyCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCategoryCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Category", and: "Select job offer category", withGesture: true)
        cell.identifier = Tag.categoryCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupSalaryRangeCell() {
        let cell = SalaryRangeCell()
        cell.setup(with: "Salary range", and: .usd)
        cell.identifier = Tag.salaryRangeCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupDescriptionCell() {
        let cell = TextViewTitleCell()
        cell.identifier = Tag.descriptionCell
        cell.setup(with: "Description")
        appendCell(cell)
    }
}

// MARK: Tags
private enum Tag {
    static let companyCell = "companyCell"
    static let categoryCell = "categoryCell"
    static let salaryRangeCell = "salaryRangeCell"
    static let positionCell = "positionCell"
    static let descriptionCell = "descriptionCell"
}
