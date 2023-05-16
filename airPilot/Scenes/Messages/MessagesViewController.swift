//
//  MessagesViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 09/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol MessagesDisplayable {
    func displayContent(_ viewModel: Messages.Content.ViewModel)
}

final class MessagesViewController: ViewController {
    // MARK: External properties
    var interactor: MessagesLogic?
    
    // MARK: Private properties
    private let messageTextField = BottomTextFieledButton()
    
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
    
    override func tapRightButton() {}
}

// MARK: MessagesDisplayable
extension MessagesViewController: MessagesDisplayable {
    func displayContent(_ viewModel: Messages.Content.ViewModel) {
        removeCells()
        setupCells(with: viewModel.messages)
        hideLoader(reloadData: true)
        scrollToLastRow(animated: false)
    }
}

// MARK: TextFieldButton
extension MessagesViewController: BottomTextFieledButtonDelegate {
    func tapButton(text: String) {
        guard text.isNotEmpty else { return }
        messageTextField.setTextField(text: String.empty)
        interactor?.sendMessage(.init(text: text))
    }
}

// MARK: TextFieldButton
extension MessagesViewController: MessageCellDelegate {
    func tapUser(userUuid: String) {
        let input = Profile.Input(userUuid: userUuid)
        let profile = Profile.createScene(input)
        push(profile)
    }
}

// MARK: External methods
extension MessagesViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension MessagesViewController {
    func setupView() {
        setupBackButton()
        setupRightButton(image: Image.call)
        setupHiddenKeyboard()
        setupTableView()
        setupMessageTextField()
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        setupInsets(bottom: Margin.large)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupMessageTextField() {
        view.addSubview(messageTextField)
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.setup()
        messageTextField.delegate = self
        
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupCells(with messages: [MessageModel]) {
        messages.forEach {
            let cell = MessageCell()
            cell.delegate = self
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
//    
//    func setupSelection(for index: IndexPath) {
////        displayLoader()
//
////        if let selectedCell = getCell(index) as? MessageCell {
////            let input = Messages.Input(planeId: selectedCell.id)
////            let plane = Plane.createScene(input)
////            push(plane)
////        }
//    }
}
