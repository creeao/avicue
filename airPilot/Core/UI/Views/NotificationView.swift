//
//  NotificationView.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

enum NotificationType {
    case success
    case failure
    case loader
}

final class NotificationBarView: UIView {
    // MARK: Private properties
    private var stackView = UIStackView()
    private var icon = UIImageView()
    private var label = UILabel()
    private var loader = LoaderView()
    
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
extension NotificationBarView {
    func display(_ type: NotificationType, with text: String = "") {
        switch type {
        case .success:
            displaySuccessNotification(with: text)
        case .failure:
            displayFailureNotification(with: text)
        case .loader:
            displayLoader()
        }
    }
    
    func hideNotification() {
        removeIconAndLabel()
    }
    
    func hideLoader() {
        removeLoader()
    }
}

// MARK: Private methods
private extension NotificationBarView {
    func setupView() {
        isHidden = true
        layer.cornerRadius = Constants.smallerCornerRadius
        backgroundColor = Color.dark
        
        setupStackView()
        setupIconAndLabel()
        setupLoader()
        addShadow()
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Margin.small.space
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.medium.top),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.regular.leading + Margin.tiny.leading),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.normal.trailing),
            stackView.bottomAnchor.constraint(equalTo: topAnchor, constant: Margin.medium.bottom),
            stackView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupIconAndLabel() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.set(width: 14, height: 14)
        icon.isHidden = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.smallMedium
        label.textColor = Color.white
        label.isHidden = true
    }
    
    func setupLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.isHidden = true
    }
    
    func displaySuccessNotification(with text: String) {
        if loader.isHidden == false {
            loader.isHidden = true
            removeLoader()
        }
        
        if icon.isHidden == false {
            changeIconAndLabel(with: text, and: Image.successNotification)
        } else {
            addIconAndLabel(with: text, and: Image.successNotification)
        }
        
        isHidden = false
        
//        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//            self?.isHidden = true
//        } completion: { [weak self] _ in
//            if self?.loader.isHidden == false {
//                UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                    self?.loader.isHidden = true
//                } completion: { [weak self] _ in
//                    self?.removeLoader()
//                    UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                        if self?.icon.isHidden == false {
//                            self?.changeIconAndLabel(with: text, and: Image.successNotification)
//                        } else {
//                            self?.addIconAndLabel(with: text, and: Image.successNotification)
//                        }
//                    } completion: { [weak self] _ in
//                        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                            self?.isHidden = false
//                        }
//                    }
//                }
//            } else {
//                UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                    self?.addIconAndLabel(with: text, and: Image.successNotification)
//                } completion: { [weak self] _ in
//                    UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                        self?.isHidden = false
//                    }
//                }
//            }
//        }
    }
    
    func displayFailureNotification(with text: String) {
        if loader.isHidden == false {
            loader.isHidden = true
            removeLoader()
        }
        
        if icon.isHidden == false {
            changeIconAndLabel(with: text, and: Image.failureNotification)
        } else {
            addIconAndLabel(with: text, and: Image.failureNotification)
        }
        
        isHidden = false
    }
    
    func displayLoader() {
        if icon.isHidden == false {
            removeIconAndLabel()
        }

        addLoader()
        isHidden = false
        
//        UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//            self?.isHidden = true
//        } completion: { [weak self] _ in
//            if self?.icon.isHidden == false {
//                UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                    self?.icon.isHidden = true
//                    self?.label.isHidden = true
//                } completion: { [weak self] _ in
//                    self?.removeIconAndLabel()
//                    UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                        self?.addLoader()
//                    }
//                }
//            } else {
//                UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                    self?.addLoader()
//                } completion: { [weak self] _ in
//                    UIView.animate(withDuration: .shortAnimationTime) { [weak self] in
//                        self?.isHidden = false
//                    }
//                }
//            }
//        }
    }
    
    func addIconAndLabel(with text: String, and image: UIImage?) {
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        
        icon.image = image
        label.text = text
        
        icon.isHidden = false
        label.isHidden = false
    }
    
    func changeIconAndLabel(with text: String, and image: UIImage?) {
        icon.image = image
        label.text = text
        
        icon.isHidden = false
        label.isHidden = false
    }
    
    func removeIconAndLabel() {
        icon.isHidden = true
        label.isHidden = true
        
        stackView.removeArrangedSubview(icon)
        stackView.removeArrangedSubview(label)
    }
    
    func addLoader() {
        stackView.addArrangedSubview(loader)
        loader.isHidden = false
    }
    
    func removeLoader() {
        loader.isHidden = true
        stackView.removeArrangedSubview(loader)
    }
}
