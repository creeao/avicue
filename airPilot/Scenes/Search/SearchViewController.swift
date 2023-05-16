//
//  SearchViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 20/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol SearchDisplayable {
    func displayUsers(_ viewModel: Search.Users.ViewModel)
    func displayCompanies(_ viewModel: Search.Companies.ViewModel)
    func displayGroups(_ viewModel: Search.Groups.ViewModel)
}

final class SearchViewController: ViewController {
    // MARK: External properties
    var interactor: SearchLogic?
    
    // MARK: Private properties
    private let searchBar = TextFieldButton()
    private var users: [UserModel] = []
    private var companies: [CompanyModel] = []
    private var groups: [GroupModel] = []
    private var lastCategory: String = Search.Categories.users.rawValue
    
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

// MARK: SearchDisplayable
extension SearchViewController: SearchDisplayable {
//    func displayContent(_ viewModel: Search.Content.ViewModel) {
//        removeCells()
//        setupCategoriesCell()
//
//        users = viewModel.users
//        setupCells(with: viewModel.users)
//        hideLoader(reloadData: true)
//    }
    
    func displayUsers(_ viewModel: Search.Users.ViewModel) {
        setupCells(with: viewModel.users)
        hideLoader(reloadData: true)
    }
    
    func displayCompanies(_ viewModel: Search.Companies.ViewModel) {
        setupCells(with: viewModel.companies)
        hideLoader(reloadData: true)
    }
    
    func displayGroups(_ viewModel: Search.Groups.ViewModel) {
        setupCells(with: viewModel.groups)
        hideLoader(reloadData: true)
    }
}

// MARK: CategoriesSliderCellDelegate
extension SearchViewController: CategoriesSliderCellDelegate {
    func tapCategory(_ id: String) {
        switch lastCategory {
        case Search.Categories.users.rawValue:
            removeCells(with: UserCell.self)
        case Search.Categories.companies.rawValue:
            removeCells(with: CompanyCell.self)
        case Search.Categories.groups.rawValue:
            removeCells(with: GroupCell.self)
        default:
            break
        }
        
        switch id {
        case Search.Categories.users.rawValue:
            interactor?.getUsers(.init())
//            setupCells(with: users)
        case Search.Categories.companies.rawValue:
            interactor?.getCompanies(.init())
//            setupCells(with: companies)
        case Search.Categories.groups.rawValue:
            interactor?.getGroups(.init())
//            setupCells(with: groups)
        default:
            break
        }
        
        lastCategory = id
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension SearchViewController {
    func getContent() {
        displayLoader()
        interactor?.getUsers(.init())
    }
}

// MARK: Private methods
private extension SearchViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupRightButton(image: Image.filter)
        setupSearchBar()
        setupHiddenKeyboard()
        setupTableView()
        setupCategoriesCell()
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setup(placeholder: "Search people, companies...", buttonImage: Image.search)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.normal.top),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        setupInsets(top: Margin.small)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCategoriesCell() {
        let categories: [CategoryViewModel] = Search.Categories.allCases.map {
            return .init(id: $0.rawValue, name: $0.getName())
        }
        
        let cell = CategoriesSliderCell()
        cell.delegate = self
        cell.setup(categories)
        appendCell(cell)
    }
    
    func setupCells(with users: [UserModel]) {
        users.forEach {
            let cell = UserCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupCells(with users: [CompanyModel]) {
        users.forEach {
            let cell = CompanyCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupCells(with users: [GroupModel]) {
        users.forEach {
            let cell = GroupCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? UserCell {
            let input = Profile.Input(userUuid: selectedCell.getUuid())
            let user = Profile.createScene(input)
            push(user)
        } else if let selectedCell = getCell(index) as? CompanyCell {
            let input = Company.Input(id: selectedCell.getId())
            let company = Company.createScene(input)
            push(company)
        } else if let selectedCell = getCell(index) as? GroupCell {
            let input = Group.Input(id: selectedCell.getId())
            let group = Group.createScene(input)
            push(group)
        }
    }
}
