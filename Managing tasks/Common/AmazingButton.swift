//
//  AmazingButton.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

/// Available presets for amazing button
enum AmazingButtonType {
    case signUp
    case signIn
    case deleteTask
    case saveTask
}

/// Button with rounded corners
class AmazingButton: UIButton {
    
    // MARK: - Constants

    private struct Constants {
       static let defaultCornerRadius: CGFloat = 18.0
    }

    // MARK: - Properties
    
    @IBInspectable var cornerRadius = Constants.defaultCornerRadius {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         render()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         render()
     }


     override func prepareForInterfaceBuilder() {
         render()
     }

    // MARK: - Public
    
    func set(type: AmazingButtonType) {
        switch type {
        case .signIn:
            self.setTitle("SIGN IN", for: .normal)
        case .signUp:
            self.setTitle("SIGN UP", for: .normal)
        case .deleteTask:
            self.setTitle("Delete task", for: .normal)
        case .saveTask:
            self.setTitle("Save task", for: .normal)
        }
    }

    // MARK: - Private
    
    private func render() {
        self.backgroundColor = UIColor.gray
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.layoutIfNeeded()
    }


//    override func layoutSubviews() {
//        self.invalidateIntrinsicContentSize()
//        super.layoutSubviews()
//    }
    
}
