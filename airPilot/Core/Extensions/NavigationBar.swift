//
//  NavigationBar.swift
//  airPilot
//
//  Created by Eryk Chrustek on 16/06/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupBackButton() {
        let backButton = UIBarButtonItem(
            image: Image.arrowBack,
            style: .done,
            target: self,
            action: #selector(routeToPreviousScreen))
        backButton.imageInsets.left = Margin.regular.space
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupLeftButton(image: UIImage?) {
        let leftButton = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(tapLeftButton))
        leftButton.imageInsets.left = Margin.regular.space
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func setupRightButton(image: UIImage?) {
        let rightButton = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(tapRightButton))
        rightButton.imageInsets.right = Margin.normal.space
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupRightButton(_ button: UIBarButtonItem) {
        button.imageInsets.right = Margin.normal.space
        navigationItem.rightBarButtonItem = button
    }
}

// MARK: Events
extension UIViewController {
    @objc func tapLeftButton() {}
    
    @objc func tapRightButton() {}
    
    @objc func routeToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
}
