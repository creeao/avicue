//
//  MenuViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 28/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol MenuDisplayable {
    func displayContent(_ viewModel: Menu.Content.ViewModel)
}

final class MenuViewController: ViewController {
    // MARK: External properties
    var interactor: MenuLogic?
    
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
        logOut()
    }
}

// MARK: MenuDisplayable
extension MenuViewController: MenuDisplayable {
    func displayContent(_ viewModel: Menu.Content.ViewModel) {
        setupElements(with: viewModel)
        hideLoader(reloadData: true)
    }
}

// MARK: MenuDisplayable
extension MenuViewController: ViewProfileCellDelegate {
    func showProfile() {
        let input = Profile.Input(userUuid: Globals.userUuid)
        let profile = Profile.createScene(input)
        push(profile)
    }
}

// MARK: MenuCompaniesCellDelegate
extension MenuViewController: MenuCompaniesCellDelegate {
    func showCompany(companyId: Int) {
        let input = Company.Input(id: companyId)
        let company = Company.createScene(input)
        push(company)
    }
}

// MARK: MenuGroupsCellDelegate
extension MenuViewController: MenuGroupsCellDelegate {
    func showGroup(groupId: Int) {
        let input = Group.Input(id: groupId)
        let group = Group.createScene(input)
        push(group)
    }
}

// MARK: MenuElementCellDelegate
extension MenuViewController: MenuElementCellDelegate {
    func tapElement(_ type: MenuElementType) {
        switch type {
        case .jobOffersPanel:
            break
        case .shopOffersPanel:
            break
        case .calendar:
            let input = Calendar.Input(calendarId: nil)
            let calendar = Calendar.createScene(input)
            push(calendar)
        case .createCompany:
            let companyCreator = CompanyCreator.createScene()
            push(companyCreator)
        case .createGroup:
            let groupCreator = GroupCreator.createScene()
            push(groupCreator)
        case .settings:
            break
        }
    }
}

// MARK: External methods
extension MenuViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
    
    func logOut() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: Private methods
private extension MenuViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
        setupProfileCell()
        setupCompaniesCell()
        setupGroupsCell()
        setupJobOffersPanelCell()
        setupShopOffersPanelCell()
        setupCalendarCell()
        setupCreateCompanyCell()
        setupCreateGroupCell()
        setupSettingsCell()
        setupButton()
    }
    
    func setupProfileCell() {
        let cell = ViewProfileCell()
        cell.setup(with: Globals.userModel)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCompaniesCell() {
        let cell = MenuCompaniesCell()
        cell.identifier = Tag.companiesCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupGroupsCell() {
        let cell = MenuGroupsCell()
        cell.identifier = Tag.groupsCell
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupJobOffersPanelCell() {
        let cell = MenuElementCell()
        cell.setup(with: Image.Menu.jobOffersPanel, and: "Job offers panel", type: .jobOffersPanel)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupShopOffersPanelCell() {
        let cell = MenuElementCell()
        cell.setup(with: Image.Menu.shopOffersPanel, and: "Shop offers panel", type: .shopOffersPanel)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCalendarCell() {
        let cell = MenuElementCell()
        cell.setup(with: Image.Menu.calendar, and: "Calendar", type: .calendar)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCreateCompanyCell() {
        let cell = MenuElementCell()
        cell.setup(with: Image.Menu.createCompany, and: "Create company", type: .createCompany)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCreateGroupCell() {
        let cell = MenuElementCell()
        cell.setup(with: Image.Menu.createGroup, and: "Create group", type: .createGroup)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupSettingsCell() {
        let cell = MenuElementCell()
        cell.setup(with: Image.Menu.settings, and: "Settings", type: .settings)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupButton() {
        setupButton(String.empty)
        button.setup(for: .bordered, with: "Log out")
    }
    
    func setupElements(with viewModel: Menu.Content.ViewModel) {
        let companiesCell = getCell(Tag.companiesCell) as? MenuCompaniesCell
        companiesCell?.setup(with: viewModel.companiesAdministrator)
        
        let groupsCell = getCell(Tag.groupsCell) as? MenuGroupsCell
        groupsCell?.setup(with: viewModel.groupsAdministrator, and: viewModel.groupsMember)
    }
}

// MARK: Tags
private enum Tag {
    static let profileCell = "profileCell"
    static let companiesCell = "companiesCell"
    static let groupsCell = "groupsCell"
    static let jobOffersPanelCell = "jobOffersPanelCell"
    static let shopOffersPanelCell = "shopOffersPanelCell"
    static let calendarCell = "calendarCell"
    static let createCompanyCell = "createCompanyCell"
    static let createGroupCell = "createGroupCell"
    static let settingsCell = "settingsCell"
}
