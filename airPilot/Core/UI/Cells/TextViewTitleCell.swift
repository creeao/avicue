//
//  TextViewTitleCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//

import UIKit

class TextViewTitleCell: CustomTableViewCell {
    // MARK: Private properties
    private let titleLabel = UILabel()
    private let textView = TextView()
    
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
extension TextViewTitleCell {
    func setup(with title: String) {
        titleLabel.text = title
    }
    
    func getText() -> String? {
        return textView.text
    }
}
    
// MARK: Private methods
private extension TextViewTitleCell {
    func setupView() {
        setupContainerView()
        setupTitleLabel()
        setupTextView()
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.miniMedium
        titleLabel.textColor = Color.gray.withHardAlpha
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func setupTextView() {
        containerView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.set(height: 200)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.mini.top),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
