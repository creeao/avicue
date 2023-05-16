//
//  ResultView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 22/11/2022.
//

import UIKit

enum ResultViewType {
    case success
    case failure
}

struct ResultModel {
    let type: ResultViewType
    var title: String = String.empty
    var description: String = String.empty
}

class ResultView: UIView {
    // MARK: Private properties
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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
extension ResultView {
    func setup(model: ResultModel) {
        switch model.type {
        case .success:
            imageView.image = Image.resultSuccess
            titleLabel.text = model.title
            descriptionLabel.text = model.description
        case .failure:
            imageView.image = Image.resultFailure
            titleLabel.text = model.title
            descriptionLabel.text = model.description
        }
    }
}

// MARK: Private methods
private extension ResultView {
    func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.set(width: 80, height: 80)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.hugeSemiBold
        titleLabel.textColor = Color.black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Margin.normal.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = Font.normalSemiBold
        descriptionLabel.textColor = Color.gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.small.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.tremendous.leading),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.tremendous.trailing),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.tremendous.bottom + Margin.tremendous.bottom)
        ])
    }
}
