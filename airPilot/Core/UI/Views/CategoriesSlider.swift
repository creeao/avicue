//
//  CategoriesSlider.swift
//  airPilot
//
//  Created by Eryk Chrustek on 24/11/2022.
//

import UIKit

protocol CategoriesSliderDelegate: AnyObject {
    func tapCategory(_ id: String)
}

final class CategoriesSlider: UIView {
    // MARK: External properties
    weak var delegate: CategoriesSliderDelegate?
    
    // MARK: Private properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var categories: [CategoryView] = []
    private var selectedCategory: Category? = nil
    
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
extension CategoriesSlider {
    func setup(_ models: [CategoryViewModel]) {
        setupElements(models)
    }
    
    func selectFirstElement() {
        guard let id = categories.first?.getId() else { return }
        selectCategory(id: id)
    }
}

// MARK: CategoryViewDelegate
extension CategoriesSlider: CategoryViewDelegate {
    func tapCategory(_ id: String) {
        selectCategory(id: id)
        delegate?.tapCategory(id)
    }
}

// MARK: UIScrollViewDelegate
extension CategoriesSlider: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
    }
}

// MARK: Private methods
private extension CategoriesSlider {
    func setupView() {
        setupScrollView()
        setupStackView()
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        
        scrollView.addShadow()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Margin.small.space
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Margin.normal.leading),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: Margin.normal.trailing),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupElements(_ models: [CategoryViewModel]) {
        models.forEach { model in
            let categoryView = CategoryView()
            categoryView.setup(model: model)
            categoryView.delegate = self
            categories.append(categoryView)
        }
        
        categories.forEach { categoryView in
            stackView.addArrangedSubview(categoryView)
        }
    }
    
    func selectCategory(id: String) {
        categories.forEach { category in
            category.setInactive()
        }
        
        categories.first(where: { $0.getId() == id })?.setActive()
    }
}
//
//
//protocol CategoriesSliderDelegate: AnyObject {
//    func tapCategory(_ category: Category)
//}
//
//final class CategoriesSlider: UIView {
//    // MARK: External properties
//    weak var delegate: CategoriesSliderDelegate?
//
//    // MARK: Private properties
//    private var scrollView = UIScrollView()
//    private var categories: [CategoryView] = []
//    private var selectedCategory: Category? = nil
//
//    // MARK: Life cycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//}
//
//// MARK: External methods
//extension CategoriesSlider {
//    func setup(_ models: [CategoryViewModel]) {
//        setupElements(models)
//    }
//}
//
//// MARK: CategoryViewDelegate
//extension CategoriesSlider: CategoryViewDelegate {
//    func tapCategory(_ category: Category) {
//        selectCategory(category: category)
//    }
//}
//
//// MARK: Private methods
//private extension CategoriesSlider {
//    func setupView() {
//        addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.contentInset = Insets.setup(right: Margin.small.space)
//        scrollView.showsHorizontalScrollIndicator = false
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    func setupElements(_ models: [CategoryViewModel]) {
//        let buttonPadding: CGFloat = 10
//        var xOffset: CGFloat = 16
//
//        models.forEach { model in
//            let categoryView = CategoryView()
//            categoryView.setup(model: model)
//            categoryView.delegate = self
//            categories.append(categoryView)
//        }
//
//        categories.forEach { categoryView in
//            categoryView.frame = CGRect(
//                x: xOffset, y: CGFloat(buttonPadding),
//                width: 110, height: 60)
//            xOffset = xOffset + buttonPadding + categoryView.frame.size.width
//
//            scrollView.addSubview(categoryView)
//        }
//
//        scrollView.contentSize = CGSize(width: xOffset, height: scrollView.frame.height)
//        categories.first?.alpha = Constants.Alpha.full
//    }
//
//    func selectCategory(category: Category) {
//        selectedCategory = category
//        categories.forEach { category in
//            category.alpha = Constants.Alpha.regular
//        }
//
//        categories.first(where: { $0.getCategory()?.id == category.id })?.alpha = Constants.Alpha.full
//        delegate?.tapCategory(category)
//    }
//}
