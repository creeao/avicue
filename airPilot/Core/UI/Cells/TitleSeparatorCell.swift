//
//  TitleSeparatorCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 17/11/2022.
//

import UIKit

class TitleSeparatorCell: CustomTableViewCell {
    // MARK: Private properties
    private let label = UILabel()
    
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
extension TitleSeparatorCell {
    func setup(with text: String) {
        label.text = text
    }
}
    
// MARK: Private methods
private extension TitleSeparatorCell {
    func setupView() {
        setupContainerView(verticalMargin: .tiny)
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.miniMedium
        label.textColor = Color.gray.withHardAlpha
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.tiny.top),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin.small.leading),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Margin.small.bottom),
        ])
    }
}
