//
//  ViewController.swift
//  airPilot
//
//  Created by Eryk Chrustek on 02/07/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Notification {
    // MARK: Properties
    lazy var stackView = UIStackView()
    lazy var tableView = UITableView()
    
    var notificationBar = NotificationBarView()
    lazy var notificationTopConstraint = NSLayoutConstraint()
    
    lazy var button = Button()
    lazy var buttonConstraint = NSLayoutConstraint()

    lazy var cells: [UITableViewCell] = []
    var backCompletion: (() -> Void)? = nil
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setupSelectionCell(for index: IndexPath) {
        // MARK: Method must be overwritten
    }
    
    func setupActionButton() {
        // MARK: Method must be overwritten
    }
}

// MARK: Setup
extension ViewController {
    func setup() {
        view.backgroundColor = Color.background
    }
    
    func setup(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.black]
    }
    
    func hideTitle() {
        setup(title: "")
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }

    func delay(seconds: DispatchTime, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: seconds) {
            completion()
        }
    }
}

// MARK: Keyboard
extension ViewController {
    func setupHiddenKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setupHideTabBar() {
        navigationController?.hidesBottomBarWhenPushed = true
    }
}

// MARK: Button & Keyboard
extension ViewController {
    func setupButton(_ title: String) {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setup(for: .enable, with: title)
        
        button.addTarget(self, action: #selector(tapActionButton), for: .touchUpInside)

        tableView.removeConstraint(on: .bottom)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.normal.leading),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.normal.trailing),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: Margin.small.top),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        tableView.removeConstraint(on: .bottom)
        handleKeyboardDisplayable()
        setupHiddenKeyboard()
    }
    
    func handleKeyboardDisplayable() {
        buttonConstraint = button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Margin.huge.bottom)
        buttonConstraint.isActive = true

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func tapActionButton() {
        setupActionButton()
    }
}

// MARK: Events
extension ViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
           let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            UIView.animate(withDuration: keyboardAnimationDuration) { [weak self] in
                self?.buttonConstraint.constant = Margin.huge.bottom
                self?.buttonConstraint.constant -= (keyboardSize.height - (self?.view.safeAreaInsets.bottom ?? Margin.normal.space))
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            UIView.animate(withDuration: keyboardAnimationDuration) { [weak self] in
                self?.buttonConstraint.constant = Margin.normal.bottom
            }
        }
    }
}

extension UIViewController {
    func push(_ viewController: UIViewController) {
        guard let navigationController = navigationController else {
            return
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop(to viewController: AnyClass, animated: Bool = true) {
        guard let navigationController else {
            Logger.log("Can't get navigation controller from view controller: \(self)")
            return
        }
        
        guard let destination = navigationController.viewControllers.filter({ type(of: $0) === viewController }).first else {
            navigationController.popToRootViewController(animated: animated)
            return
        }
        
        navigationController.popToViewController(destination, animated: animated)
    }
    
    func getViewController(type viewController: AnyClass, animated: Bool = true) -> UIViewController? {
        guard let navigationController else {
            Logger.log("Can't get navigation controller from view controller: \(self)")
            return nil
        }
        
        guard let destination = navigationController.viewControllers.filter({ type(of: $0) === viewController }).first else {
            return nil
        }
        
        return destination
    }
    
    func getViewControllerFromTabBar(type viewController: AnyClass, animated: Bool = true) -> UIViewController? {
        guard let navigationController else {
            Logger.log("Can't get navigation controller from view controller: \(self)")
            return nil
        }
        
        guard let destination = (navigationController.viewControllers.filter({ type(of: $0) === TabBarController.self }).first)?.children.filter({ type(of: $0) === viewController }).last else {
            return nil
        }
        
        return destination
    }
}
