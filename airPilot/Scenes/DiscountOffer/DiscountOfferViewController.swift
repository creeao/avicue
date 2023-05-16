//
//  DiscountOfferViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 12/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol DiscountOfferDisplayable {
    func displayContent(_ viewModel: DiscountOffer.Content.ViewModel)
}

final class DiscountOfferViewController: ViewController {
    // MARK: External properties
    var interactor: DiscountOfferLogic?
    
    // MARK: Private properties
    private var favouriteBarButton = FavouriteBarButton()
    private var buttonView = ButtonView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: DiscountOfferDisplayable
extension DiscountOfferViewController: DiscountOfferDisplayable {
    func displayContent(_ viewModel: DiscountOffer.Content.ViewModel) {
        hideLoader(reloadData: true)
    }
}

// MARK: External methods
extension DiscountOfferViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension DiscountOfferViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupTableView(for: self)
        setupButton("Copy code")
    }
}
