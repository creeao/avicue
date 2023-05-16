//
//  TabBar.swift
//  airPilot
//
//  Created by Eryk Chrustek on 19/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTitle()
    }
}

// MARK: Private methods
private extension TabBarController {
    func setupView() {
        viewControllers = getViewControllers()
        tabBar.backgroundColor = Color.background
        tabBar.layer.addBorder(
            edge: .top,
            color: Color.gray.withFrailAlpha,
            thickness: Constants.borderWidth)
    }
    
    func getViewControllers() -> [UIViewController] {
        TabItem.allCases.map {
            let viewController = $0.getViewController()
            let activeImage = $0.getImage(isActive: true)
            let inactiveImage = $0.getImage(isActive: false)
            let tabBarItem = UITabBarItem(title: nil, image: inactiveImage, selectedImage: activeImage)
            tabBarItem.standardAppearance = .none
            
            viewController.tabBarItem = tabBarItem
            return viewController
        }
    }
    
    func showTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
    }
    
    func hideTitle() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = true
    }
}
