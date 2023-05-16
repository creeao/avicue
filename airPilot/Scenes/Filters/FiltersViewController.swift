//
//  FiltersViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/08/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol FiltersDisplayable {
    func displayContent(_ viewModel: Filters.Content.ViewModel)
}

final class FiltersViewController: ViewController {
    // MARK: External properties
    var interactor: FiltersLogic?
    
    // MARK: Private properties

    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup(title: "Filters")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideTitle()
    }
}

// MARK: FiltersDisplayable
extension FiltersViewController: FiltersDisplayable {
    func displayContent(_ viewModel: Filters.Content.ViewModel) {
        
    }
}

// MARK: External methods
extension FiltersViewController {
    func getContent() {
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension FiltersViewController {
    func setupView() {
        setupBackButton()
        setupStackView()
    }
}
