//
//  TableView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

typealias TableViewMethods = UITableViewDelegate & UITableViewDataSource
typealias TableViewType = UIViewController & TableViewMethods

extension ViewController {
    func setupTableView(for viewController: TableViewType, withConstraints: Bool = true, toSafeArea: Bool = false) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = viewController
        tableView.dataSource = viewController
        tableView.separatorStyle = .none
        tableView.backgroundColor = Color.background
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        
        if withConstraints {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: toSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor)
            ])
        }
        
        setupInsets()
    }
    
    func setupInsets(top: Margin = Margin.normal, bottom: Margin = Margin.normal) {
        tableView.contentInset = Insets.setup(
            top: top.space,
            bottom: bottom.space)
        tableView.scrollIndicatorInsets = Insets.setup(
            top: top.space,
            bottom: bottom.space)
    }
    
    func register(_ cell: UITableViewCell.Type) {
        tableView.register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    
    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach {
            tableView.register($0, forCellReuseIdentifier: String(describing: $0))
        }
    }
    
    func appendCell(_ cell: UITableViewCell) {
        cells.append(cell)
    }
    
    func getCell(_ index: IndexPath) -> UITableViewCell {
        return cells[index.row]
    }
    
    func getCell(_ identifier: String) -> UITableViewCell? {
        return (cells as? [CustomTableViewCell])?.first(where: { $0.identifier == identifier })
    }
    
    func removeCells() {
        cells.removeAll()
    }
    
    func removeCells(with someType: AnyClass) {
        cells.removeAll(where: { type(of: $0) === someType })
    }
}

extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    
    func getCell(_ cell: UITableViewCell.Type, with indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath)
    }
}

// MARK: Table view methods
extension ViewController: TableViewMethods {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupSelectionCell(for: indexPath)
    }
}

// MARK: Scroll
extension ViewController {
    func scrollToLastRow(animated: Bool) {
        if cells.count > 0 {
            tableView.scrollToRow(at: IndexPath(item: cells.count - 1, section: 0), at: .bottom, animated: animated)
        }
    }
}
