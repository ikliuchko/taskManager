//
//  SignUpViewController.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, StoryboardLoadable {
    
    // MARK: - Constants
    
    private struct Constants {
        static let signInText = "Let's sign up"
        static let emailLabelText = "Your email (no spam guaranteed)"
        static let passwordLabelText = "Your most secure password"
        static let emailHintText = "yes, put your email here"
        static let passwordHintText = "the best place to put your password"
    }
    
    static let storyboardName: StoryboardName = .signUp
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTitleLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: AmazingButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var activityAnimator: UIActivityIndicatorView!
    
    private let userService = UserService()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        addNotificationObserver(name: UIResponder.keyboardWillShowNotification.rawValue, selector: #selector(keyboardWillShow))
        addNotificationObserver(name: UIResponder.keyboardWillHideNotification.rawValue, selector: #selector(keyboardWillHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        removeNotificationObserver(name: UIResponder.keyboardWillShowNotification.rawValue)
        removeNotificationObserver(name: UIResponder.keyboardWillHideNotification.rawValue)
    }
    
    
    // MARK: - Public
    
    // MARK: - Private
    
    private func setupUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        titleLabel.text = Constants.signInText
        
        emailTitleLabel.text = Constants.emailLabelText
        emailTextField.placeholder = Constants.emailHintText
        
        passwordTitleLabel.text = Constants.passwordLabelText
        passwordTextField.placeholder = Constants.passwordHintText
        
        signUpButton.set(type: .signUp)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            scrollView.contentInset.bottom = keyboardFrame.cgRectValue.height
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
    
    private func performSignUp() {
        signUpButton.isEnabled = false
        activityAnimator.startAnimating()
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                signUpButton.isEnabled = true
                activityAnimator.stopAnimating()
                return
        }
        userService.registerUser(with: email, password: password)
            .ensure { [weak self] in
                self?.signUpButton.isEnabled = true
                self?.activityAnimator.stopAnimating()
        }
        .done { [weak self] in
            let taskVC = TasksViewController.fromStoryboard()
            self?.navigationController?.pushViewController(taskVC, animated: true)
        }
        .catch { [weak self] error in
            self?.presentDefaultErrorAlert(error: error)
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func signUp(_ sender: Any) {
        performSignUp()
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
