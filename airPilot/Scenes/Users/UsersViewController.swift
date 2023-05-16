//
//  UsersViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol UsersDisplayable {
    func displayContent(_ viewModel: Users.Content.ViewModel)
}

final class UsersViewController: ViewController {
    // MARK: External properties
    var interactor: UsersLogic?
    
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

// MARK: UsersDisplayable
extension UsersViewController: UsersDisplayable {
    func displayContent(_ viewModel: Users.Content.ViewModel) {
        setupCells(with: viewModel.users)
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension UsersViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension UsersViewController {
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
    
    func setupCells(with users: [UserModel]) {
        users.forEach {
            let cell = UserCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? UserCell {
            let input = Profile.Input(userUuid: selectedCell.getUuid())
            let profile = Profile.createScene(input)
            push(profile)
        }
    }
}
