//
//  UserService.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import PromiseKit

class UserService {
    
    // MARK: - Properties
    
    private let userRepository = UserRepository()
    private let userStorage = UserSecureStorage()
    
    // MARK: - Public
    
    func refreshToken() -> Promise<Void> {
        guard let currentCreds = userStorage.getUserCreadentials() else {
            return Promise.init(error: NSError(domain: "TaskManager", code: 0, userInfo: [:]))
        }
        return loginUser(with: currentCreds.email, password: currentCreds.password)
    }

    func registerUser(with email: String, password: String) -> Promise<Void> {
        userRepository.registerUser(with: email, password: password)
    }

    func loginUser(with email: String, password: String) -> Promise<Void> {
        userRepository.loginUser(with: email, password: password)
    }
}
