//
//  GroupViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 29/12/2022.
//  Copyright © 2022 ACC. All rights reserved.
//

import UIKit

protocol GroupDisplayable {
    func displayContent(_ viewModel: Group.Content.ViewModel)
}

final class GroupViewController: ViewController {
    // MARK: External properties
    var interactor: GroupLogic?
    
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

// MARK: GroupDisplayable
extension GroupViewController: GroupDisplayable {
    func displayContent(_ viewModel: Group.Content.ViewModel) {
        removeCells()
        setupCell(with: viewModel.group)
        setupPostCreatorCell()
        setupCells(with: viewModel.posts)
        hideLoader(reloadData: true)
    }
}

// MARK: PostCellDelegate
extension GroupViewController: ActivityCellDelegate {
    func tapUser(userUuid: String) {
        let input = Profile.Input(userUuid: userUuid)
        let profile = Profile.createScene(input)
        push(profile)
    }
    
    func tapLikeButton(postId: Int, isLike: Bool) {
//        interactor?.tapLikeButton(.init(postId: postId, commentId: nil, isLike: isLike))
    }
    
    func tapLikeButton(commentId: Int, isLike: Bool) {
//        interactor?.tapLikeButton(.init(postId: nil, commentId: commentId, isLike: isLike))
    }
    
    func tapPost(postId: Int) {}
    func tapShopOffer(offerId: Int) {}
    func tapJobOffer(offerId: Int) {}
}

// MARK: GroupProfileCellDelegate
extension GroupViewController: GroupProfileCellDelegate {
    func showPosts(groupId: Int) {
        
    }
    
    func showMembers(groupId: Int) {
        
    }
    
    func showCalendar(calendarId: Int) {
        let input = Calendar.Input(calendarId: calendarId)
        let calendar = Calendar.createScene(input)
        push(calendar)
    }
    
    func showMessages(conversationId: Int) {
        let input = Messages.Input(conversationId: conversationId, userUuid: nil)
        let messages = Messages.createScene(input)
        push(messages)
    }
}

// MARK: PostCellDelegate
extension GroupViewController: PostCreatorCellDelegate {
    func createPost(_ text: String) {
        interactor?.createPost(.init(text: text))
    }
}

// MARK: PostCellDelegate
extension GroupViewController: PostCellDelegate {
    func tapPostAuthor(userUuid: String) {}
    
    func tapShareButton() {
        
    }
    
    func tapLikeButton(postId: Int) {
//        interactor?.likePost(.init(postId: postId))
    }
}


// MARK: External methods
extension GroupViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension GroupViewController {
    func setupView() {
        setupBackButton()
        setupTableView(for: self)
    }
    
    func setupCell(with group: GroupModel) {
        let cell = GroupProfileCell()
        cell.setup(with: group)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupPostCreatorCell() {
        let cell = PostCreatorCell()
        cell.setup(with: Globals.userModel?.avatar, and: "Add post")
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCells(with posts: [PostModel]) {
        posts.forEach {
//            let cell = PostCell()
//            let cell =
//            cell.setup(with: $0, and: false, withActivity: false)
//            cell.delegate = self
            let cell = ActivityCell()
            cell.setup(with: .init(id: $0.id, type: .post, post: $0))
            cell.delegate = self
            appendCell(cell)
        }
    }
}
