//
//  GroupsViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/01/2023.
//  Copyright © 2023 ACC. All rights reserved.
//

import UIKit

protocol GroupsDisplayable {
    func displayContent(_ viewModel: Groups.Content.ViewModel)
}

final class GroupsViewController: ViewController {
    // MARK: External properties
    var interactor: GroupsLogic?
    
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

// MARK: GroupsDisplayable
extension GroupsViewController: GroupsDisplayable {
    func displayContent(_ viewModel: Groups.Content.ViewModel) {
        setupCells(with: viewModel.groups)
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension GroupsViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension GroupsViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
    }
    
    func setupCells(with companies: [GroupModel]) {
        companies.forEach {
            let cell = GroupCell()
            cell.setup(with: $0)
            appendCell(cell)
        }
    }
    
    func setupSelection(for index: IndexPath) {
        if let selectedCell = getCell(index) as? GroupCell,
           let eventModel = selectedCell.getModel() {
            if let eventCreator = getViewController(type: EventCreatorViewController.self) {
                (eventCreator as? EventCreatorViewController)?.selectGroup(eventModel)
                pop(to: EventCreatorViewController.self)
            }
        }
    }
}
