//
//  UIView+Extensions.swift
//  Managing tasks
//
//  Created by JBS Solutions on 16.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

extension UIView {
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
