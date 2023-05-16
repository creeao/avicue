//
//  EventCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 07/01/2023.
//

import UIKit

protocol EventCellDelegate: AnyObject {
    func tapUser(userUuid: String)
    func tapSendMessageButton(userUuid: String, eventId: Int)
}

class EventCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: EventCellDelegate?
    
    // MARK: Private properties
    private let eventView = EventView()
    private let actionsView = ActionsView()
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: External methods
extension EventCell {
    func setup(with event: EventModel) {
        id = event.id
        eventView.setup(with: event)
        actionsView.setup(with: .event(event))
    }
}

// MARK: ActionsViewDelegate
extension EventCell: ActionsViewDelegate {
    func tapPostAuthor(userUuid: String) {
        delegate?.tapUser(userUuid: userUuid)
    }
    
    func tapSendMessageButton(userUuid: String, eventId: Int) {
        delegate?.tapSendMessageButton(userUuid: userUuid, eventId: id)
    }
    
    func tapCommentButton(postId: Int) {}
    func tapLikeButton(postId: Int, isLike: Bool) {}
    func tapLikeButton(commentId: Int, isLike: Bool) {}
}

// MARK: Events
private extension EventCell {
    @objc func createPost() {
//        guard let text = textField.text, text.isNotEmpty else { return }
//        delegate?.createPost(text)
    }
}
    
// MARK: Private methods
private extension EventCell {
    func setupView() {
        setupContainerView()
        setupEventView()
        setupActionsView()
    }
    
    func setupEventView() {
        containerView.addSubview(eventView)
        eventView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.mini.top),
            eventView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            eventView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.mini.bottom)
        ])
    }
    
    func setupActionsView() {
        containerView.addSubview(actionsView)
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.delegate = self
        
        NSLayoutConstraint.activate([
            actionsView.centerYAnchor.constraint(equalTo: eventView.centerYAnchor),
            actionsView.leadingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: Margin.regular.leading),
            actionsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionsView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
}
