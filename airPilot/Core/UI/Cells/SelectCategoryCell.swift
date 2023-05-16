//
//  SelectCategoryCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 27/11/2022.
//

import UIKit

protocol SelectCategoryCellDelegate: AnyObject {
    func showSubcategories(_ category: Category)
    func selectCategory(_ category: Category)
}

final class SelectCategoryCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: SelectCategoryCellDelegate?
    
    // MARK: Private properties
    private var category: Category? = nil
    private let labelContainer = UIView()
    private let label = UILabel()
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
extension SelectCategoryCell {
    func setup(with model: Category) {
        category = model
        label.text = model.name?.capitalized
        
        if (model.categories ?? []).isEmpty {
            setupForCategory()
        } else {
            setupForSubcategories()
        }
    }
    
    func getCategory() -> Category? {
        return category
    }
}

// MARK: Events
private extension SelectCategoryCell {
    @objc func selectCategory() {
        guard let category else { return }
        delegate?.selectCategory(category)
    }
    
    @objc func showSubcategories() {
        guard let category else { return }
        delegate?.showSubcategories(category)
    }
}
    
// MARK: Private methods
private extension SelectCategoryCell {
    func setupView() {
        setupContainerView()
        setupLabelContainer()
    }
    
    func setupLabelContainer() {
        containerView.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.backgroundColor = Color.white
        labelContainer.addShadow()
        labelContainer.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            labelContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            labelContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            labelContainer.heightAnchor.constraint(equalToConstant: Constants.Size.listElement)
        ])
        
        setupNameLabel()
    }
    
    func setupNameLabel() {
        labelContainer.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.normalSemiBold
        label.textColor = Color.black
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: Margin.normal.leading),
            label.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor)
        ])
    }
    
    func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setup(for: .filledImage, and: Image.arrowRight)
        button.addTarget(self, action: #selector(showSubcategories), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: labelContainer.topAnchor),
            button.leadingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: Margin.medium.leading),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.Size.listElement),
            button.widthAnchor.constraint(equalToConstant: Constants.Size.listElement),
        ])
    }
    
    func setupForCategory() {
        NSLayoutConstraint.activate([
            labelContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        let action = UITapGestureRecognizer(target: self, action: #selector(selectCategory))
        contentView.addGestureRecognizer(action)
        contentView.isUserInteractionEnabled = true
    }
    
    func setupForSubcategories() {
        setupButton()
        
        let action = UITapGestureRecognizer(target: self, action: #selector(showSubcategories))
        contentView.addGestureRecognizer(action)
        contentView.isUserInteractionEnabled = true
    }
}
