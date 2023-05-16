//
//  ConversationsViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol ConversationsDisplayable {
    func displayContent(_ viewModel: Conversations.Content.ViewModel)
}

final class ConversationsViewController: ViewController {
    // MARK: External properties
    var interactor: ConversationsLogic?
    
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

// MARK: ConversationsDisplayable
extension ConversationsViewController: ConversationsDisplayable {
    func displayContent(_ viewModel: Conversations.Content.ViewModel) {
        setupCells(with: viewModel.conversations)
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension ConversationsViewController {
    func getContent() {
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension ConversationsViewController {
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
        searchBar.setup(placeholder: "Search messages", buttonImage: Image.search)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.normal.top),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        tableView.contentInset = Insets.setup(top: Margin.small.top)
        tableView.scrollIndicatorInsets = Insets.setup(top: Margin.small.top)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCells(with conversations: [ConversationModel]) {
        conversations.forEach {
            let cell = ConversationCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let cell = getCell(index) as? ConversationCell {
            let input = Messages.Input(conversationId: cell.getId(), userUuid: nil)
            let messages = Messages.createScene(input)
            push(messages)
        }
    }
}
