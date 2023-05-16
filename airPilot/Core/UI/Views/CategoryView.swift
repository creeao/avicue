//
//  CategoryView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 25/11/2022.
//

import UIKit

struct CategoryViewModel {
//    let image: UIImage?
//    let
//    let category: Category
    let id: String
    let name: String
}

protocol CategoryViewDelegate: AnyObject {
    func tapCategory(_ id: String)
}

class CategoryView: UIView {
    // MARK: External properties
    weak var delegate: CategoryViewDelegate?
    
    // MARK: Private properties
//    private let imageView = UIImageView()
//    private let label = UILabel()
//    private var category: Category? = nil
    
    private var id: String = String.empty
    private let view = UIView()
    private let label = UILabel()
//    private var category: Category? = nil
    
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
extension CategoryView {
    func setup(model: CategoryViewModel) {
//        category = model.category
        id = model.id
        label.text = model.name
        setupInactiveStyle()
//        imageView.image = model.image
    }
    
//    func getCategory() -> Category? {
//        return category
//    }
    
    func getId() -> String {
        return id
    }
    
    func setActive() {
        setupActiveStyle()
    }
    
    func setInactive() {
        setupInactiveStyle()
    }
}

// MARK: Events
private extension CategoryView {
    @objc func tapView() {
//        guard let category else { return }
        delegate?.tapCategory(id)
    }
}

// MARK: Private methods
private extension CategoryView {
    func setupView() {
        setupBackground()
        setupLabel()
        setupGesture()
    }
    
    func setupBackground() {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
//        view.alpha = Constants.Alpha.regular
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.littleMedium
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.small.top),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.regular.leading),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.regular.trailing),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.small.bottom)
        ])
    }
    
    func setupActiveStyle() {
        alpha = Constants.Alpha.hard
        view.backgroundColor = Color.salmon.withMiniAlpha
        view.layer.borderColor = Color.transparent.cgColor
        label.textColor = Color.salmon
    }
    
    func setupInactiveStyle() {
        alpha = Constants.Alpha.hard
        view.backgroundColor = Color.transparent
        view.layer.borderColor = Color.gray.withMiniAlpha.cgColor
        view.layer.borderWidth = Constants.borderWidth
        label.textColor = Color.gray
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(target: self, action: #selector(tapView))
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
}

//struct CategoryViewModel {
//    let image: UIImage?
//    let category: Category
//}
//
//protocol CategoryViewDelegate: AnyObject {
//    func tapCategory(_ path: Category)
//}
//
//class CategoryView: UIView {
//    // MARK: External properties
//    weak var delegate: CategoryViewDelegate?
//
//    // MARK: Private properties
//    private let imageView = UIImageView()
//    private let label = UILabel()
//    private var category: Category? = nil
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
//extension CategoryView {
//    func setup(model: CategoryViewModel) {
//        category = model.category
//
//        label.text = model.category.name
//        imageView.image = model.image
//    }
//
//    func getCategory() -> Category? {
//        return category
//    }
//}
//
//// MARK: Events
//private extension CategoryView {
//    @objc func tapView() {
//        guard let category else { return }
//        delegate?.tapCategory(category)
//    }
//}
//
//// MARK: Private methods
//private extension CategoryView {
//    func setupView() {
//        setupImageView()
//        setupLabel()
//        setupGesture()
//    }
//
//    func setupImageView() {
//        alpha = Constants.Alpha.regular
//        addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = Constants.cornerRadius
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    func setupLabel() {
//        addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = Font.normalSemiBold
//        label.textColor = Color.white
//
//        NSLayoutConstraint.activate([
//            label.centerYAnchor.constraint(equalTo: centerYAnchor),
//            label.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
//    }
//
//    func setupGesture() {
//        let action = UITapGestureRecognizer(target: self, action: #selector(tapView))
//        addGestureRecognizer(action)
//        isUserInteractionEnabled = true
//    }
//}


struct NewCategoryViewModel {
    
}

protocol NewCategoryViewDelegate: AnyObject {
//    func tapCategory(_ path: Category)
}

class NewCategoryView: UIView {
    // MARK: External properties
    weak var delegate: NewCategoryViewDelegate?
    
    // MARK: Private properties
    private let view = UIView()
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
extension NewCategoryView {
    func setup(model: NewCategoryViewModel) {
//        category = model.category
//
//        label.text = model.category.name
//        imageView.image = model.image
    }
    
//    func getCategory() -> Category? {
//        return category
//    }
}

// MARK: Events
private extension NewCategoryView {
    @objc func tapView() {
//        guard let category else { return }
//        delegate?.tapCategory(category)
    }
}

// MARK: Private methods
private extension NewCategoryView {
    func setupView() {
        setupBackground()
        setupLabel()
        setupGesture()
    }
    
    func setupBackground() {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.littleMedium
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.small.top),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.small.leading),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.small.trailing),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.small.bottom)
        ])
    }
    
    func setupActiveStyle() {
        view.backgroundColor = Color.salmon.withMiniAlpha
        view.layer.borderColor = Color.transparent.cgColor
        label.textColor = Color.salmon
    }
    
    func setupInactiveStyle() {
        view.backgroundColor = Color.transparent
        view.layer.borderColor = Color.gray.withMiniAlpha.cgColor
        view.layer.borderWidth = Constants.borderWidth
        label.textColor = Color.gray
    }
    
    func setupGesture() {
        let action = UITapGestureRecognizer(target: self, action: #selector(tapView))
        addGestureRecognizer(action)
        isUserInteractionEnabled = true
    }
}
