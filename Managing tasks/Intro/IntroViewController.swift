//
//  IntroViewController.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, StoryboardLoadable {
 
    // MARK: - Constants

    private struct Constants {
        static let titleLabelText = "Hello, it's time to ..."
    }
    
    static let storyboardName = StoryboardName.intro

    // MARK: - Properties
    
    @IBOutlet private weak var signInButton: AmazingButton!
    @IBOutlet private weak var signUpButton: AmazingButton!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - Private
    
    private func setupUI() {
        signInButton.set(type: .signIn)
        signUpButton.set(type: .signUp)
        
        titleLabel.text = Constants.titleLabelText
    }
    
    // MARK: - Actions
    
    @IBAction private func signIn(_ sender: Any) {
        let signInVC = SignInViewController.fromStoryboard()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction private func signUp(_ sender: Any) {
        let signUpVC = SignUpViewController.fromStoryboard()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
