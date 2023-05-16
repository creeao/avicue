//
//  ResultScreenViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol ResultScreenDelegate: AnyObject {
    func returnAction()
}

protocol ResultScreenDisplayable {
    func displayContent(_ viewModel: ResultScreen.Content.ViewModel)
}

final class ResultScreenViewController: ViewController {
    // MARK: External properties
    var interactor: ResultScreenLogic?
    weak var delegate: ResultScreenDelegate?
    
    // MARK: Private properties
    private var resultView = ResultView()
    private var buttonView = ButtonView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: ResultScreenDisplayable
extension ResultScreenViewController: ResultScreenDisplayable {
    func displayContent(_ viewModel: ResultScreen.Content.ViewModel) {
        resultView.setup(model: viewModel.result)
        hideLoader(reloadData: true)
    }
}

// MARK: ButtonViewDelegate
extension ResultScreenViewController: ButtonViewDelegate {
    func tapButton() {
        backCompletion?()
    }
}

// MARK: External methods
extension ResultScreenViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension ResultScreenViewController {
    func setupView() {
        hideNavigationBar()
        setupResultView()
        setupButtonView()
    }
    
    func setupResultView() {
        view.addSubview(resultView)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.tremendous.leading),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.tremendous.trailing),
            resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupButtonView() {
        view.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.setup(style: .enable, title: "Close", backgroundColor: Color.background)
        buttonView.delegate = self
                
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
