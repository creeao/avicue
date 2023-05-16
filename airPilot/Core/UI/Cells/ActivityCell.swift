//
//  ActivityCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 18/11/2022.
//

import UIKit

enum ActivityWithModelType {
    case ownPost(PostModel)
    case likedPost(PostModel, UserModel)
    case sharedPost(PostModel, UserModel)
    case sharedShopOffer(ShopOfferModel, UserModel)
    case sharedJobOffer(JobOfferModel, UserModel)
}

//enum ActivityType: String {
//    case ownPost = "
//    case likedPost
//    case sharedPost
//    case commentedPost
//    case sharedShopOffer
//    case sharedJobOffer
//    
//    OWN_POST = "OWN_POST",
//    LIKED_POST = "LIKED_POST",
//    COMMENTED_POST = "COMMENTED_POST",
//    SHARED_POST = "SHARED_POST",
//    SHARED_JOB_OFFER = "SHARED_JOB_OFFER",
//    SHARED_SHOP_OFFER = "SHARED_SHOP_OFFER"
//}

//struct ActivityModel {
//    var ownPost: PostModel? = nil
//    var likedPost: PostModel? = nil
//    var sharedPost: PostModel? = nil
//    var sharedShopOffer: ShopOfferModel? = nil
//    var sharedJobOffer: JobOfferModel? = nil
//    var comment: CommentModel? = nil
//
//    var type: ActivityType
//    var user: UserModel? = nil
//}

protocol ActivityCellDelegate: AnyObject {
    func tapUser(userUuid: String)
    func tapPost(postId: Int)
    func tapLikeButton(postId: Int, isLike: Bool)
    func tapLikeButton(commentId: Int, isLike: Bool)
    func tapShopOffer(offerId: Int)
    func tapJobOffer(offerId: Int)
}

class ActivityCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: ActivityCellDelegate?
    
    // MARK: Private properties
    private let labelView = ActivityLabelView()
    private let postMessageView = PostMessageView()
    private let actionsView = ActionsView()
    private let shopOfferView = ShopOfferView()
    private let jobOfferView = JobOfferView()
    
    private var activityType: ActivityType = .post
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContainerView()
    }
}

// MARK: External methods
extension ActivityCell {
    func setup(with model: ActivityModel) {
        switch model.type {
        case .post:
            guard let post = model.post else { return }
            setupOwnPost(with: post)
        case .postLiked:
            guard let post = model.post, let friendsActivity = model.friendsActivity else { return }
            setupLikedPost(with: post, and: friendsActivity)
        case .postShared:
            guard let post = model.post, let friendsActivity = model.friendsActivity else { return }
            setupSharedPost(with: post, and: friendsActivity)
        case .shopOfferShared:
            guard let offer = model.shopOffer, let friendsActivity = model.friendsActivity else { return }
            setupSharedShopOffer(with: offer, and: friendsActivity)
        case .jobOfferShared:
            guard let offer = model.jobOffer, let friendsActivity = model.friendsActivity else { return }
            setupSharedJobOffer(with: offer, and: friendsActivity)
        case .comment:
            guard let comment = model.comment else { return }
            setupComment(with: comment)
        }
    }
}

// MARK: ActionsViewDelegate
extension ActivityCell: ActivityLabelViewDelegate {
    func tapUser(userUuid: String) {
        delegate?.tapUser(userUuid: userUuid)
    }
}

// MARK: ActionsViewDelegate
extension ActivityCell: PostMessageViewDelegate {
    func tapPost(postId: Int) {
        delegate?.tapPost(postId: postId)
    }
}

// MARK: ActionsViewDelegate
extension ActivityCell: ActionsViewDelegate {
    func tapPostAuthor(userUuid: String) {
        delegate?.tapUser(userUuid: userUuid)
    }
    
    func tapCommentButton(postId: Int) {
        delegate?.tapPost(postId: postId)
    }
    
    func tapLikeButton(postId: Int, isLike: Bool) {
        isLike ? postMessageView.likeUp() : postMessageView.likeDown()
        delegate?.tapLikeButton(postId: postId, isLike: isLike)
    }
    
    func tapLikeButton(commentId: Int, isLike: Bool) {
        isLike ? postMessageView.likeUp() : postMessageView.likeDown()
        delegate?.tapLikeButton(commentId: commentId, isLike: isLike)
    }
    
    func tapSendMessageButton(userUuid: String, eventId: Int) {}
}

// MARK: ActionsViewDelegate
extension ActivityCell: ShopOfferViewDelegate {
    func tapShopOffer(offerId: Int) {
        delegate?.tapShopOffer(offerId: offerId)
    }
}

// MARK: ActionsViewDelegate
extension ActivityCell: JobOfferViewDelegate {
    func tapJobOffer(offerId: Int) {
        delegate?.tapJobOffer(offerId: offerId)
    }
}

// MARK: Private methods
private extension ActivityCell {
    func setupOwnPost(with post: PostModel) {
        activityType = .post
        setupOwnPostView()
        setupActionsView()
        
        postMessageView.setup(with: post)
        actionsView.setup(with: .post(post))
    }
    
    func setupLikedPost(with post: PostModel, and friendsActivity: [UserActivity]) {
        activityType = .postLiked
        setupLabelView()
        setupLikedPostView()
        setupActionsView()
        
        labelView.setup(friendsActivity: friendsActivity, description: "liked this post.")
        postMessageView.setup(with: post)
        actionsView.setup(with: .post(post))
    }
    
    func setupSharedPost(with post: PostModel, and friendsActivity: [UserActivity]) {
        activityType = .postShared
        setupLabelView()
        setupSharedPostView()
        setupActionsView()
        
        labelView.setup(friendsActivity: friendsActivity, description: "shared this post.")
        postMessageView.setup(with: post)
        actionsView.setup(with: .post(post))
    }
    
    func setupSharedShopOffer(with offer: ShopOfferModel, and friendsActivity: [UserActivity]) {
        activityType = .shopOfferShared
        setupLabelView()
        setupShopOfferView()
        
        labelView.setup(friendsActivity: friendsActivity, description: "shared this offer.")
        shopOfferView.setup(with: offer)
    }
    
    func setupSharedJobOffer(with offer: JobOfferModel, and friendsActivity: [UserActivity]) {
        activityType = .jobOfferShared
        setupLabelView()
        setupJobOfferView()
        
        labelView.setup(friendsActivity: friendsActivity, description: "shared this offer.")
        jobOfferView.setup(with: offer)
    }
    
    func setupComment(with comment: CommentModel) {
        activityType = .comment
        setupOwnPostView()
        setupActionsView()
        
        postMessageView.setup(with: comment)
        actionsView.setup(with: .comment(comment))
    }
    
    func setupLabelView() {
        containerView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.delegate = self
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.mini.top),
            labelView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.normal.leading),
        ])
    }
    
    func setupOwnPostView() {
        containerView.addSubview(postMessageView)
        postMessageView.translatesAutoresizingMaskIntoConstraints = false
        postMessageView.delegate = self
        
        NSLayoutConstraint.activate([
            postMessageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.mini.top),
            postMessageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postMessageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
    
    func setupLikedPostView() {
        containerView.addSubview(postMessageView)
        postMessageView.translatesAutoresizingMaskIntoConstraints = false
        postMessageView.delegate = self
        
        NSLayoutConstraint.activate([
            postMessageView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: Margin.small.top),
            postMessageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postMessageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
    
    func setupSharedPostView() {
        containerView.addSubview(postMessageView)
        postMessageView.translatesAutoresizingMaskIntoConstraints = false
        postMessageView.delegate = self
        
        NSLayoutConstraint.activate([
            postMessageView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: Margin.small.top),
            postMessageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postMessageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
    
    func setupActionsView() {
        containerView.addSubview(actionsView)
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.delegate = self
        
        NSLayoutConstraint.activate([
            actionsView.centerYAnchor.constraint(equalTo: postMessageView.centerYAnchor),
            actionsView.leadingAnchor.constraint(equalTo: postMessageView.trailingAnchor, constant: Margin.regular.leading),
            actionsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionsView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupShopOfferView() {
        containerView.addSubview(shopOfferView)
        shopOfferView.translatesAutoresizingMaskIntoConstraints = false
        shopOfferView.delegate = self
        
        NSLayoutConstraint.activate([
            shopOfferView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: Margin.small.top),
            shopOfferView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            shopOfferView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            shopOfferView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
    
    func setupJobOfferView() {
        containerView.addSubview(jobOfferView)
        jobOfferView.translatesAutoresizingMaskIntoConstraints = false
        jobOfferView.delegate = self
        
        NSLayoutConstraint.activate([
            jobOfferView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: Margin.small.top),
            jobOfferView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            jobOfferView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            jobOfferView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
}
