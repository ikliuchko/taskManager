//
//  MainViewController.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var activityAnimator: UIActivityIndicatorView!
    private let userService = UserService()

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        checkUserLoggedIn()
    }

    // MARK: - Lifecycle

    // MARK: - Public

    // MARK: - Private
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func checkUserLoggedIn() {
        userService.refreshToken()
            .done { [weak self] in
                self?.navigateToTasksScreen()
        }
        .recover { [weak self] error in
            self?.navigateToIntroScreen()
        }
        .ensure { [weak self] in
            self?.activityAnimator.stopAnimating()
        }
        .catch { [weak self] error in
            self?.presentDefaultErrorAlert(error: error)
        }
    }

    private func navigateToIntroScreen() {
        let introVC = IntroViewController.fromStoryboard()
        navigationController?.pushViewController(introVC, animated: true)
    }
    
    private func navigateToTasksScreen() {
        let tasksVC = TasksViewController.fromStoryboard()
        navigationController?.pushViewController(tasksVC, animated: true)
    }
}
