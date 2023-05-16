//
//  PostMessageView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 03/12/2022.
//

import UIKit

protocol PostMessageViewDelegate: AnyObject {
    func tapPost(postId: Int)
}

final class PostMessageView: UIView {
    // MARK: External properties
    weak var delegate: PostMessageViewDelegate?
    
    // MARK: Private properties
    private let authorLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let additionalInformationsView = UIStackView()
    private let dateView = PostImageLabelView()
    private let commentsView = PostImageLabelView()
    private let likesView = PostImageLabelView()

    private var postId: Int = 0
    private var likesCount: Int = 0
    private var commentsCount: Int = 0
    
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
extension PostMessageView {
    func setup(with post: PostModel) {
        postId = post.id
        authorLabel.text = post.createdBy?.getName()
        messageLabel.text = post.text

        setupDateView(post.createdDate)
        setupCommentsView(post.commentsCount)
        setupLikesView(post.likesCount)
        
        likesCount = post.likesCount.orZero
        commentsCount = post.commentsCount.orZero
    }
    
    func setup(with comment: CommentModel) {
        postId = comment.id
        authorLabel.text = comment.createdBy?.getName()
        messageLabel.text = comment.text
        
        setupDateView(comment.createdDate)
        setupLikesView(comment.likesCount)
        
        likesCount = comment.likesCount.orZero
    }
    
    func likeUp() {
        likesCount += 1
        likesView.setup(with: likesCount.toString)
    }
    
    func likeDown() {
        if likesCount > 0 { likesCount -= 1 }
        likesView.setup(with: likesCount.toString)
    }
}

// MARK: Events
private extension PostMessageView {
    @objc func tapPost() {
        delegate?.tapPost(postId: postId)
    }
}

// MARK: Private methods
private extension PostMessageView {
    func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Color.white
        addShadow()
        
        setupAuthorLabel()
        setupMessageLabel()
        setupAdditionalInformationsView()
    }
    
    func setupAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = Font.bigSemiBold
        authorLabel.textColor = Color.black
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin.normal.top),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupMessageLabel() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = Font.largeRegular
        messageLabel.textColor = Color.black
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Margin.small.top),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.normal.trailing),
        ])
    }
    
    func setupAdditionalInformationsView() {
        addSubview(additionalInformationsView)
        additionalInformationsView.translatesAutoresizingMaskIntoConstraints = false
        additionalInformationsView.axis = .horizontal
        additionalInformationsView.spacing = Margin.small.space
        additionalInformationsView.alpha = Constants.Alpha.hard
        
        NSLayoutConstraint.activate([
            additionalInformationsView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Margin.medium.top),
            additionalInformationsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.normal.leading),
            additionalInformationsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.normal.bottom),
        ])
    }
    
    func setupDateView(_ date: String?) {
        dateView.setup(with: Image.Post.date, and: setupDate(date))
        additionalInformationsView.addArrangedSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCommentsView(_ commentsCount: Int?) {
        if let commentsCount = commentsCount?.toString {
            addSeparatorView()
            commentsView.setup(with: Image.Post.comment, and: commentsCount)
            additionalInformationsView.addArrangedSubview(commentsView)
            commentsView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupLikesView(_ likesCount: Int?) {
        if let likesCount = likesCount?.toString {
            addSeparatorView()
            likesView.setup(with: Image.Post.like, and: likesCount)
            additionalInformationsView.addArrangedSubview(likesView)
            likesView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addSeparatorView() {
        let separatorView = UIImageView()
        separatorView.image = Image.Post.separator
        separatorView.set(width: 1, height: 11)
        
        additionalInformationsView.addArrangedSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(
            target: self,
            action: #selector(tapPost))
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
    
    func setupDate(_ date: String?) -> String {
        guard let time = date?.date(dateStyle: .omitted, timeStyle: .shortened),
              let fullDate = date?.date(dateStyle: .abbreviated, timeStyle: .omitted) else {
            return String.empty
        }

        return time + String.pauseWithSpaces + fullDate
    }
}
