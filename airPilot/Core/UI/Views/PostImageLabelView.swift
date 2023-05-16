//
//  PostImageLabelView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/12/2022.
//

import UIKit

final class PostImageLabelView: UIView {
    // MARK: External properties
    weak var delegate: PostMessageViewDelegate?
    
    // MARK: Private properties
    private let imageView = UIImageView()
    private let label = UILabel()
    
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
extension PostImageLabelView {
    func setup(with image: UIImage?, and text: String) {
        imageView.image = image
        label.text = text
    }
    
    func setup(with text: String) {
        label.text = text
    }
}

// MARK: Private
private extension PostImageLabelView {
    func setupView() {
        setupImageView()
        setupLabel()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 11),
            imageView.widthAnchor.constraint(equalToConstant: 11)
        ])
    }
    
    func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.miniMedium
        label.textColor = Color.gray
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Margin.mini.leading),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
