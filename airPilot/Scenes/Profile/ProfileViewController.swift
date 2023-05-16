//
//  ProfileViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 30/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol ProfileDisplayable {
    func displayContent(_ viewModel: Profile.Content.ViewModel)
}

final class ProfileViewController: ViewController {
    // MARK: External properties
    var interactor: ProfileLogic?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

// MARK: ProfileDisplayable
extension ProfileViewController: ProfileDisplayable {
    func displayContent(_ viewModel: Profile.Content.ViewModel) {
        removeCells()
        setupCell(with: viewModel.profile)
//        setupCell(with: viewModel.profile.details)
        setupCells(with: viewModel.profile.jobHistory)
//        setupCells(with: viewModel.profile.posts)
        hideLoader(reloadData: true)
    }
}

// MARK: ProfileCellDelegate
extension ProfileViewController: ProfileCellDelegate {
    func tapActionOnUserButton(actionOnUser: ActionOnUserType) {
        if actionOnUser == .editProfile {
            let editProfile = EditProfile.createScene()
            push(editProfile)
        } else {
            interactor?.actionOnUser(.init(actionOnUser: actionOnUser))
        }
    }
    
    func tapFriendsCount(userUuid: String) {
        let input = Users.Input(userUuid: userUuid, type: .friends)
        let friends = Users.createScene(input)
        push(friends)
    }
    
    func tapMessageButton(userUuid: String) {
        let input = Messages.Input(conversationId: nil, userUuid: userUuid)
        let messages = Messages.createScene(input)
        push(messages)
    }
}

// MARK: WorkHistoryCellDelegate
extension ProfileViewController: JobHistoryCellDelegate {
    func tapView(model: JobHistoryModel) {
        let company = Company.createScene(.init(id: (model.assignedTo?.id).orZero))
        push(company)
    }
}

// MARK: PostCellDelegate
extension ProfileViewController: PostCellDelegate {
    func tapPostAuthor(userUuid: String) {}
    
    func tapShareButton() {
        
    }
    
    func tapLikeButton(postId: Int) {
        interactor?.likePost(.init(postId: postId))
    }
}

// MARK: External methods
extension ProfileViewController {
    func getContent() {
        displayLoader()
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension ProfileViewController {
    func setupView() {
        setupTableView(for: self)
    }
    
    func setupNavigationBar() {
        showNavigationBar()
        setupBackButton()
    }
    
    func setupCell(with profile: ProfileModel) {
        let cell = ProfileCell()
        cell.setup(with: profile, isUserProfile: Globals.userUuid == (profile.user?.uuid).orEmpty)
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCell(with details: [InformationModel]?) {
        guard let details, details.isNotEmpty else { return }
        let titleCell = TitleCell()
        titleCell.setup(with: "Details")
        appendCell(titleCell)
        
        let cell = InformationsCell()
        cell.setup(with: details)
        appendCell(cell)
    }
    
    func setupCells(with jobkHistory: [JobHistoryModel]?) {
        guard let jobkHistory, jobkHistory.isNotEmpty else { return }
        let titleCell = TitleCell()
        titleCell.setup(with: "Job history")
        appendCell(titleCell)
        
        jobkHistory.forEach {
            let cell = JobHistoryCell()
            cell.setup(with: $0)
            cell.delegate = self
            appendCell(cell)
        }
    }
    
    func setupCells(with posts: [PostModel]?) {
        guard let posts, posts.isNotEmpty else { return }
        let titleCell = TitleCell()
        titleCell.setup(with: "Activity")
        appendCell(titleCell)
        
        posts.forEach {
            let cell = PostCell()
            cell.setup(with: $0, and: true, withActivity: true)
            cell.delegate = self
            appendCell(cell)
        }
    }
}
