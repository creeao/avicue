//
//  Notification.swift
//  airPilot
//
//  Created by Eryk Chrustek on 15/09/2022.
//  Copyright © 2022 airPilot. All rights reserved.
//

import UIKit

protocol Notification {
    var notificationBar: NotificationBarView { get }
}

extension Notification where Self: ViewController {
    func displayNotification(_ type: NotificationType, with text: String) {
        guard let notification = getNotificationBar() else {
//            showNotificationBar(notificationBar, with: type, completion: nil)
            return
        }
        
//        notification.display(type, with: text)
//        delay(seconds: .now() + 3) {
//            UIView.animate(withDuration: .shortAnimationTime) {
//                notification.alpha = Constants.Alpha.zero
//            } completion: { _ in
//                notification.hideNotification()
//                notification.isHidden = true
//                notification.alpha = Constants.Alpha.full
//            }
//        }
    }
    
    func displayLoader() {
        guard let notification = getNotificationBar() else {
//            showNotificationBar(notificationBar, with: .loader, completion: nil)
            return
        }
        
//        notification.display(.loader)
        tableView.alpha = Constants.Alpha.zero
        
        UIView.animate(withDuration: .regularAnimationTime) {
//            notification.alpha = Constants.Alpha.full
        }
    }
    
    func hideLoader(reloadData: Bool = false) {
        if reloadData {
            tableView.reloadData()
        }

        if let notification = getNotificationBar() {
            UIView.animate(withDuration: .regularAnimationTime) { [weak self] in
//                notification.alpha = Constants.Alpha.zero
                self?.tableView.alpha = Constants.Alpha.full
            } completion: { _ in
//                notification.hideLoader()
//                notification.isHidden = true
            }
        }
    }
}

private extension Notification where Self: ViewController {
    func getView() -> UIView? {
        return navigationController?.view ?? nil
    }
    
    func getNotificationBar() -> NotificationBarView? {
        guard let subviews = navigationController?.view.subviews else { return nil }
        guard let notification = subviews.first(where: { $0 is NotificationBarView }) as? NotificationBarView else { return nil }
        return notification
    }
    
    func showNotificationBar(_ notification: NotificationBarView, with type: NotificationType, completion: (() -> Void)?) {
        guard let parentView = getView() else { return }
        
        parentView.addSubview(notification)
        notification.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notification.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 50),
            notification.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            notification.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        UIView.transition(with: parentView, duration: .shortAnimationTime) {
            notification.display(type)
        } completion: { _ in
            completion?()
        }
    }
}
