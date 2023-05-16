//
//  JobHistoryCreatorViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol JobHistoryCreatorDisplayable {
    func displayContent(_ viewModel: JobHistoryCreator.Content.ViewModel)
    func displayResult(_ response: JobHistoryCreator.AddJobHistory.ViewModel)
}

final class JobHistoryCreatorViewController: ViewController {
    // MARK: External properties
    var interactor: JobHistoryCreatorLogic?
    
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
        addJobHistory()
    }
}

// MARK: JobHistoryCreatorDisplayable
extension JobHistoryCreatorViewController: JobHistoryCreatorDisplayable {
    func displayContent(_ viewModel: JobHistoryCreator.Content.ViewModel) {
        hideLoader(reloadData: true)
    }
    
    func displayResult(_ response: JobHistoryCreator.AddJobHistory.ViewModel) {
        let input = ResultScreen.Input(result: response.result)
        let result = ResultScreen.createScene(input)
        push(result)
        
        result.backCompletion = { [weak self] in
            let controller = self?.getViewController(type: ProfileViewController.self)
            (controller as? ProfileViewController)?.getContent()
            self?.pop(to: ProfileViewController.self)
        }
    }
}

// MARK: TextFieldTitleLogoButtonCellDelegate
extension JobHistoryCreatorViewController: TextFieldTitleLogoButtonCellDelegate {
    func tapView() {
        let companies = Companies.createScene()
        push(companies)
    }
}

// MARK: External methods
extension JobHistoryCreatorViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func selectCompany(_ model: CompanyModel) {
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        companyCell?.select(with: model)
    }
    
    func addJobHistory() {
        let companyCell = getCell(Tag.companyCell) as? TextFieldTitleLogoButtonCell
        let positionCell = getCell(Tag.positionCell) as? TextFieldTitleCell
        
        interactor?.addJobHistory(.init(
            assignedTo: companyCell?.id,
            position: positionCell?.getText(),
            startDate: nil,
            endDate: nil))
    }
}

// MARK: Private methods
private extension JobHistoryCreatorViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupTitleCell()
        setupCompanyCell()
        setupPositionCell()
        setupStartDateCell()
        setupEndDateCell()
        setupButton("Add work")
    }
    
    func setupTitleCell() {
        let cell = LargeTitleCell()
        cell.setup(with: "Add job history", toLeft: true)
        appendCell(cell)
    }
    
    func setupCompanyCell() {
        let cell = TextFieldTitleLogoButtonCell()
        cell.setup(with: "Assigned to company", and: "Select company")
        cell.identifier = Tag.companyCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupPositionCell() {
        let cell = TextFieldTitleCell()
        cell.setup(with: "Position", and: "e.g. First Officer B737")
        cell.identifier = Tag.positionCell
        appendCell(cell)
    }
    
    func setupStartDateCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "Start end", and: "13 sept. 1980", type: .calendar)
        cell.identifier = Tag.startDateCell
        appendCell(cell)
    }
    
    func setupEndDateCell() {
        let cell = TextFieldTitleButtonCell()
        cell.setup(with: "End date", and: "13 sept. 1980", type: .calendar)
        cell.identifier = Tag.endDateCell
        appendCell(cell)
    }
    
}

// MARK: Tags
private enum Tag {
    static let companyCell = "companyCell"
    static let positionCell = "positionCell"
    static let startDateCell = "startDateCell"
    static let endDateCell = "endDateCell"
}
