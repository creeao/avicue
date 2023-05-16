//
//  JobOfferViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 11/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol JobOfferDisplayable {
    func displayContent(_ viewModel: JobOffer.Content.ViewModel)
}

final class JobOfferViewController: ViewController {
    // MARK: External properties
    var interactor: JobOfferLogic?
    
    // MARK: Private properties
    private var buttonView = ButtonView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: JobOfferDisplayable
extension JobOfferViewController: JobOfferDisplayable {
    func displayContent(_ viewModel: JobOffer.Content.ViewModel) {
        setupCell(with: viewModel.offer)
        setupCell(with: viewModel.informations)
        setupCell(with: viewModel.offer.text)
        hideLoader(reloadData: true)
    }
}

// MARK: ButtonViewDelegate
extension JobOfferViewController: ButtonViewDelegate {
    func tapButton() {}
}

// MARK: External methods
extension JobOfferViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension JobOfferViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupTableView()
        setupButtonView()
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        tableView.contentInset = Insets.setup(top: Margin.small.space, bottom: Margin.huge.space)
        tableView.scrollIndicatorInsets = Insets.setup(top: Margin.small.space, bottom: Margin.huge.space)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupCell(with offer: JobOfferModel) {
        let cell = JobOfferCell()
        cell.setup(with: offer)
        appendCell(cell)
    }
    
    func setupCell(with informations: [InformationModel]) {
        let cell = InformationsCell()
        cell.setup(with: informations)
        appendCell(cell)
    }
    
    func setupCell(with description: String?) {
        let cell = DescriptionCell()
        cell.setup(with: description.orEmpty)
        appendCell(cell)
    }
    
    func setupButtonView() {
        view.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.setup(style: .enable, title: "Send CV", backgroundColor: Color.background)
        buttonView.delegate = self
                
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Margin.small.bottom),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
