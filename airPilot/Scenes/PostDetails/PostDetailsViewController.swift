//
//  PostDetailsViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol PostDetailsDisplayable {
    func displayContent(_ viewModel: PostDetails.Content.ViewModel)
}

final class PostDetailsViewController: ViewController {
    // MARK: External properties
    var interactor: PostDetailsLogic?
    
    // MARK: Private properties
    private let commentTextField = BottomTextFieledButton()
    
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
}

// MARK: TextFieldButton
extension PostDetailsViewController: BottomTextFieledButtonDelegate {
    func tapButton(text: String) {
        guard text.isNotEmpty else { return }
        commentTextField.setTextField(text: String.empty)
        interactor?.commentPost(.init(text: text))
    }
}

// MARK: PostDetailsDisplayable
extension PostDetailsViewController: PostDetailsDisplayable {
    func displayContent(_ viewModel: PostDetails.Content.ViewModel) {
        removeCells()
        setupCell(with: viewModel.post)
        setupCells(with: viewModel.comments)
        hideLoader(reloadData: true)
    }
}

// MARK: PostCellDelegate
extension PostDetailsViewController: ActivityCellDelegate {
    func tapUser(userUuid: String) {
        let input = Profile.Input(userUuid: userUuid)
        let profile = Profile.createScene(input)
        push(profile)
    }
    
    func tapLikeButton(postId: Int, isLike: Bool) {
        interactor?.tapLikeButton(.init(postId: postId, commentId: nil, isLike: isLike))
    }
    
    func tapLikeButton(commentId: Int, isLike: Bool) {
        interactor?.tapLikeButton(.init(postId: nil, commentId: commentId, isLike: isLike))
    }
    
    func tapPost(postId: Int) {}
    func tapShopOffer(offerId: Int) {}
    func tapJobOffer(offerId: Int) {}
}

// MARK: External methods
extension PostDetailsViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension PostDetailsViewController {
    func setupView() {
        showNavigationBar()
        setupBackButton()
        setupTableView()
        setupCommentTextField()
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
    
    func setupCommentTextField() {
        view.addSubview(commentTextField)
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.setup()
        commentTextField.delegate = self
        
        NSLayoutConstraint.activate([
            commentTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            commentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupCell(with post: ActivityModel) {
        let cell = ActivityCell()
        cell.setup(with: post)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCells(with comments: [ActivityModel]) {
        guard comments.isNotEmpty else { return }
        let titleCell = TitleCell()
        titleCell.setup(with: "Comments", font: Font.hugeBold, color: Color.gray.withLightAlpha)
        appendCell(titleCell)
        
        comments.forEach {
            let cell = ActivityCell()
            cell.setup(with: $0)
            cell.delegate = self
            appendCell(cell)
        }
    }
}
