//
//  HomeViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol HomeDisplayable {
    func displayContent(_ viewModel: Home.Content.ViewModel)
}

final class HomeViewController: ViewController {
    // MARK: External properties
    var interactor: HomeLogic?
    
    // MARK: Private properties
    private let headerView = UIView()
    private let logoView = UIImageView()
    private let headerButtonsView = UIStackView()
    private let searchButton = Button()
    private let messagesButton = Button()
    private let notificationsButton = Button()
    private let menuButton = Button()
    private let separatorView = UIView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getContent()
    }
}

// MARK: HomeDisplayable
extension HomeViewController: HomeDisplayable {
    func displayContent(_ viewModel: Home.Content.ViewModel) {
        setupPostCreatorCell()
        setupCells(with: viewModel.activities)
        hideLoader(reloadData: true)
    }
}

// MARK: Events
extension HomeViewController {
    @objc func tapSearchButton() {
        let search = Search.createScene()
        push(search)
    }
    
    @objc func tapMessagesButton() {
        let convesrations = Conversations.createScene()
        push(convesrations)
    }
    
    @objc func tapNotificationsButton() {
        let notifications = JobOfferCreator.createScene()
        push(notifications)
    }
    
    @objc func tapMenuButton() {
        let menu = Menu.createScene()
        push(menu)
//        let input = Profile.Input(userId: 1, isUserProfile: false)
//        let profile = Profile.createScene(input)
//        push(profile)
    }
}

// MARK: PostCellDelegate
extension HomeViewController: PostCreatorCellDelegate {
    func createPost(_ text: String) {
        interactor?.createPost(.init(text: text))
    }
}

// MARK: PostCellDelegate
extension HomeViewController: ActivityCellDelegate {
    func tapUser(userUuid: String) {
        let input = Profile.Input(userUuid: userUuid)
        let profile = Profile.createScene(input)
        push(profile)
    }
    
    func tapPost(postId: Int) {
        let input = PostDetails.Input(postId: postId)
        let postDetails = PostDetails.createScene(input)
        push(postDetails)
    }
    
    func tapLikeButton(postId: Int, isLike: Bool) {
        interactor?.tapLikeButton(.init(postId: postId, isLike: isLike))
    }
    
    func tapShopOffer(offerId: Int) {
        let input = ShopOffer.Input(id: offerId)
        let shopOffer = ShopOffer.createScene(input)
        push(shopOffer)
    }
    
    func tapJobOffer(offerId: Int) {
        let input = JobOffer.Input(id: offerId)
        let jobOffer = JobOffer.createScene(input)
        push(jobOffer)
    }
    
    func tapLikeButton(commentId: Int, isLike: Bool) {}
}

// MARK: External methods
extension HomeViewController {
    func getContent() {
        interactor?.getContent(.init())
    }
}

// MARK: Private methods
private extension HomeViewController {
    func setupView() {
        setupHeaderView()
        setupSeparatorView()
        setupTableView()
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.normal.top),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing)
        ])
        
        setupLogoView()
        setupHeaderButtonsView()
    }
    
    func setupLogoView() {
        headerView.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = Image.logo
        logoView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            logoView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Margin.normal.leading),
            logoView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    func setupHeaderButtonsView() {
        headerView.addSubview(headerButtonsView)
        headerButtonsView.translatesAutoresizingMaskIntoConstraints = false
        headerButtonsView.axis = .horizontal
        headerButtonsView.spacing = Margin.small.space
        
        NSLayoutConstraint.activate([
            headerButtonsView.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerButtonsView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: Margin.normal.trailing),
            headerButtonsView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        setupSearchButton()
        setupMessagesButton()
        setupNotificationsButton()
        setupMenuButton()
    }
    
    func setupSearchButton() {
        searchButton.setup(for: .filledImage, and: Image.search)
        searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)

        setupButton(searchButton, with: headerButtonsView)
    }
    
    func setupMessagesButton() {
        messagesButton.setup(for: .filledImage, and: Image.messages)
        messagesButton.addTarget(self, action: #selector(tapMessagesButton), for: .touchUpInside)
        
        setupButton(messagesButton, with: headerButtonsView)
    }
    
    func setupNotificationsButton() {
        notificationsButton.setup(for: .filledImage, and: Image.notifications)
        notificationsButton.addTarget(self, action: #selector(tapNotificationsButton), for: .touchUpInside)
        
        setupButton(notificationsButton, with: headerButtonsView)
    }
    
    func setupMenuButton() {
        menuButton.setup(for: .filledImage, and: Image.menu)
        menuButton.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
        
        setupButton(menuButton, with: headerButtonsView)
    }
    
    func setupButton(_ button: UIButton, with stackView: UIStackView) {
        stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupSeparatorView() {
        view.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Color.gray.withFrailAlpha
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Margin.normal.top),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.borderWidth)
        ])
    }
    
    func setupTableView() {
        setupTableView(for: self, withConstraints: false)
        setupInsets(top: Margin.small)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupPostCreatorCell() {
        let cell = PostCreatorCell()
        cell.setup(with: Globals.userModel?.avatar, and: "Type something...")
        cell.delegate = self
        appendCell(cell)
    }
    
    func setupCells(with activites: [ActivityModel]) {
        activites.forEach {
            let cell = ActivityCell()
            cell.setup(with: $0)
            cell.delegate = self
            appendCell(cell)
        }
    }
}
