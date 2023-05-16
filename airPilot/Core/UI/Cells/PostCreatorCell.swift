//
//  PostCreatorCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 06/01/2023.
//

import UIKit

protocol PostCreatorCellDelegate: AnyObject {
    func createPost(_ text: String)
}

class PostCreatorCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: PostCreatorCellDelegate?
    
    // MARK: Private properties
    private let logoView = UIImageView()
    private let textField = TextField()
    private let textView = UITextView()
    private let button = Button()
    
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
extension PostCreatorCell {
    func setup(with image: String?, and placeholder: String) {
        logoView.getImage(from: image)
        textField.setupPlaceholder(placeholder, aligment: .left, height: Constants.Size.textField)
    }
}

// MARK: Events
private extension PostCreatorCell {
    @objc func createPost() {
        guard let text = textField.text, text.isNotEmpty else { return }
        delegate?.createPost(text)
    }
}
    
// MARK: Private methods
private extension PostCreatorCell {
    func setupView() {
        setupContainerView()
        setupLogoView()
        setupTextField()
        setupButton()
//        setupGesture()
    }

    func setupLogoView() {
        containerView.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = Image.empty
        logoView.layer.masksToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.layer.borderWidth = Constants.borderWidth
        logoView.layer.borderColor = Color.gray.withThinAlpha.cgColor
        logoView.layer.cornerRadius = Constants.smallerCornerRadius
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: containerView.topAnchor),
            logoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            logoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 38),
            logoView.widthAnchor.constraint(equalToConstant: 38),
        ])
    }
    
    func setupTextField() {
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: Margin.medium.leading),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupButton() {
        containerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setup(for: .filledImage, and: Image.plusButton)
        button.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Margin.medium.leading),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 38),
            button.widthAnchor.constraint(equalToConstant: 38),
        ])
    }
    
    func setupGesture() {
        let gestureView = UIView()
        containerView.addSubview(gestureView)
        gestureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gestureView.topAnchor.constraint(equalTo: containerView.topAnchor),
            gestureView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gestureView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gestureView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
//        gestureView.addGesture(self, #selector(tapView))
    }
}
