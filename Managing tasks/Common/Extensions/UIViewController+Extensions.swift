//
//  UIViewController+Extensions.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Notification

    func addNotificationObserver(name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: Notification.Name(name), object: nil)
    }

    func removeNotificationObserver(name: String) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(name), object: nil)
    }
    
    func presentDefaultErrorAlert(error: Error, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Oopsie", message: "Something went wrong ;) \n \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: completion)
    }
    
    @objc func hideKeyboardWhenTappedAround() {
        view.hideKeyboardWhenTappedAround()
    }

    @objc func dismissKeyboard() {
        view.dismissKeyboard()
    }
}

