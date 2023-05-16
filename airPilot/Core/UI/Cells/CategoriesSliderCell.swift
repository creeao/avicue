//
//  CategoriesSliderCell.swift
//  airPilot
//
//  Created by Eryk Chrustek on 08/02/2023.
//

import UIKit

protocol CategoriesSliderCellDelegate: AnyObject {
    func tapCategory(_ id: String)
}

class CategoriesSliderCell: CustomTableViewCell {
    // MARK: External properties
    weak var delegate: CategoriesSliderCellDelegate?
    
    // MARK: Private properties
    let categories = CategoriesSlider()
    
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
extension CategoriesSliderCell {
    func setup(_ models: [CategoryViewModel]) {
        categories.setup(models)
        categories.selectFirstElement()
    }
}

// MARK: CategoryViewDelegate
extension CategoriesSliderCell: CategoriesSliderDelegate {
    func tapCategory(_ id: String) {
        delegate?.tapCategory(id)
    }
}
    
// MARK: Private methods
private extension CategoriesSliderCell {
    func setupView() {
        setupContainerView(horiztonalMargin: .zero)
        setupCategoriesSlider()
    }
    
    func setupCategoriesSlider() {
        containerView.addSubview(categories)
        categories.translatesAutoresizingMaskIntoConstraints = false
        categories.delegate = self
        
        NSLayoutConstraint.activate([
            categories.topAnchor.constraint(equalTo: containerView.topAnchor),
            categories.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categories.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categories.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
