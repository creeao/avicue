//
//  AviationOfferViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol AviationOfferDisplayable {
    func displayContent(_ viewModel: AviationOffer.Content.ViewModel)
}

final class AviationOfferViewController: ViewController {
    // MARK: External properties
    var interactor: AviationOfferLogic?

    // MARK: Private properties
    private var buttonView = ButtonView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: AviationOfferDisplayable
extension AviationOfferViewController: AviationOfferDisplayable {
    func displayContent(_ viewModel: AviationOffer.Content.ViewModel) {
//        setupCell(with: viewModel.offer)
//        setupCell(with: viewModel.informations)
//        setupCell(with: viewModel.description)
        hideLoader(reloadData: true)
    }
}

// MARK: ButtonViewDelegate
extension AviationOfferViewController: ButtonViewDelegate {
    func tapButton() {}
}

// MARK: External methods
extension AviationOfferViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension AviationOfferViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupTableView()
        setupButtonView()
    }
    
    func setupTableView() {
        setupTableView(for: self, toSafeArea: true)
        tableView.contentInset = Insets.setup(top: Margin.small.top)
        tableView.scrollIndicatorInsets = Insets.setup(top: Margin.small.top)
    }
    
    func setupCell(with offer: AviationOfferModel) {
//        let cell = AviationOfferCell()
//        cell.setup(with: offer)
//        appendCell(cell)
    }
    
    func setupCell(with informations: [InformationModel]) {
        let cell = InformationsCell()
        cell.setup(with: informations)
        appendCell(cell)
    }
    
    func setupCell(with description: String) {
        let cell = DescriptionCell()
        cell.setup(with: description)
        appendCell(cell)
    }
    
    func setupButtonView() {
        view.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.setup(style: .enable, title: "Send CV", backgroundColor: Color.background)
        buttonView.delegate = self
                
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
