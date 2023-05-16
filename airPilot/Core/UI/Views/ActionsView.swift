//
//  ActionsView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 03/12/2022.
//

import UIKit

protocol ActionsViewDelegate: AnyObject {
    func tapPostAuthor(userUuid: String)
    func tapCommentButton(postId: Int)
    func tapLikeButton(postId: Int, isLike: Bool)
    func tapLikeButton(commentId: Int, isLike: Bool)
    func tapSendMessageButton(userUuid: String, eventId: Int)
}

enum ActionsViewType {
    case post(PostModel)
    case comment(CommentModel)
    case event(EventModel)
}

final class ActionsView: UIView {
    // MARK: External properties
    weak var delegate: ActionsViewDelegate?
    
    // MARK: Private properties
    private let avatarImageView = UIImageView()
    private let stackView = UIStackView()
    private let commentButton = ActionButton()
    private let likeButton = ActionButton()
    private let sendMessageButton = ActionButton()
    
    private var userUuid: String = String.empty
    private var postId: Int = 0
    private var commentId: Int = 0
    private var eventId: Int = 0
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension ActionsView {
    func setup(with type: ActionsViewType) {
        switch type {
        case .post(let post):
            postId = post.id
            userUuid = (post.createdBy?.uuid).orEmpty
            avatarImageView.getImage(from: post.createdBy?.avatar)
            setupCommentButton()
            setupLikeButton()
            post.isLiked.isTrue ? likeButton.setActive() : likeButton.setInactive()
        case .comment(let comment):
            commentId = comment.id
            userUuid = (comment.createdBy?.uuid).orEmpty
            avatarImageView.getImage(from: comment.createdBy?.avatar)
            setupLikeButton()
            comment.isLiked.isTrue ? likeButton.setActive() : likeButton.setInactive()
        case .event(let event):
            eventId = event.id
            userUuid = (event.createdBy?.uuid).orEmpty
            avatarImageView.getImage(from: event.createdBy?.avatar)
            setupSendMessageButton()
//            avatarImageView.getImage(from: event.createdBy?.avatar)
        }
    }
//    func setup(with post: PostModel) {
//        postId = post.id
//        userId = (post.createdBy?.id).orZero
//
//        avatarImageView.getImage(from: post.createdBy?.avatar)
//        post.likedBy.contains(Globals.userId) ? likeButton.setActive() : likeButton.setInactive()
//    }
//
//    func setup(with comment: CommentModel) {
//        postId = comment.id
//        userId = (comment.createdBy?.id).orZero
//
//        avatarImageView.getImage(from: comment.createdBy?.avatar)
//        comment.likedBy.contains(Globals.userId) ? likeButton.setActive() : likeButton.setInactive()
//    }
    
    func isLiked() -> Bool {
        likeButton.checkState()
    }
}

// MARK: Events
private extension ActionsView {
    @objc func tapPostAuthor() {
        delegate?.tapPostAuthor(userUuid: userUuid)
    }
    
    @objc func tapCommentButton() {
        delegate?.tapCommentButton(postId: postId)
    }
    
    @objc func tapLikeButton() {
        if likeButton.checkState() {
            likeButton.setInactive()
            if postId.isZero {
                delegate?.tapLikeButton(commentId: commentId, isLike: false)
            } else {
                delegate?.tapLikeButton(postId: postId, isLike: false)
            }
        } else {
            likeButton.setActive()
            if postId.isZero {
                delegate?.tapLikeButton(commentId: commentId, isLike: true)
            } else {
                delegate?.tapLikeButton(postId: postId, isLike: true)
            }
        }
        
//        likeButton.checkState() ? likeButton.setInactive() : likeButton.setActive()
//        delegate?.tapLikeButton(postId: postId)
//
//        if postId.isZero {
//            delegate?.tapLikeButton(commentId: commentId)
//        } else {
//            delegate?.tapLikeButton(postId: postId)
//        }
    }
    
    @objc func tapSendMessageButton() {
        delegate?.tapSendMessageButton(userUuid: userUuid, eventId: eventId)
    }
}

// MARK: Private methods
private extension ActionsView {
    func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Color.white.withLightAlpha
        addShadow()
        
        setupAvatarImageView()
        setupStackView()
    }
    
    func setupAvatarImageView() {
        addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.cornerRadius
        
        let action = UITapGestureRecognizer(target: self, action: #selector(tapPostAuthor))
        avatarImageView.addGestureRecognizer(action)
        avatarImageView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mini.top),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mini.leading),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.mini.trailing),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Margin.medium.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.regular.top),
            stackView.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.little.bottom),
            stackView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupCommentButton() {
        stackView.addArrangedSubview(commentButton)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.setup(inactiveImage: Image.comment, activeImage: Image.comment)
        commentButton.addTarget(self, action: #selector(tapCommentButton), for: .touchUpInside)
        commentButton.set(width: 25, height: 25)
        
//        addSubview(commentButton)
//        commentButton.translatesAutoresizingMaskIntoConstraints = false
//        commentButton.setup(inactiveImage: Image.comment, activeImage: Image.shareFilled)
//        commentButton.addTarget(self, action: #selector(tapCommentButton), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            commentButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.regular.top),
//            commentButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
//            commentButton.heightAnchor.constraint(equalToConstant: 25),
//            commentButton.widthAnchor.constraint(equalToConstant: 25),
//        ])
    }
    
    func setupLikeButton() {
        stackView.addArrangedSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setup(inactiveImage: Image.like, activeImage: Image.likeFilled)
        likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)

        likeButton.set(width: 25, height: 25)
        
//        addSubview(likeButton)
//        likeButton.translatesAutoresizingMaskIntoConstraints = false
//        likeButton.setup(inactiveImage: Image.like, activeImage: Image.likeFilled)
//        likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            likeButton.topAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: Margin.regular.top),
//            likeButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
//            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.regular.bottom),
//            likeButton.heightAnchor.constraint(equalToConstant: 25),
//            likeButton.widthAnchor.constraint(equalToConstant: 25),
//        ])
    }
    
    func setupSendMessageButton() {
        stackView.addArrangedSubview(sendMessageButton)
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        sendMessageButton.setup(inactiveImage: Image.Post.message, activeImage: Image.Post.message)
        sendMessageButton.addTarget(self, action: #selector(tapSendMessageButton), for: .touchUpInside)

        sendMessageButton.set(width: 25, height: 25)
    }
}
