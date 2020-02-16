//
//  UserService.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import PromiseKit
import SwaggerClient

class UserService {
    
    // MARK: - Properties
    
    private let userStorage = UserSecureStorage()
    private let sessionClient = SessionClient()
    
    // MARK: - Public
    
    func refreshToken() -> Promise<Void> {
        guard let currentCreds = userStorage.getUserCreadentials() else {
            return Promise.init(error: NSError(domain: "TaskManager", code: 0, userInfo: [:]))
        }
        return loginUser(with: currentCreds.email, password: currentCreds.password)
    }

    func registerUser(with email: String, password: String) -> Promise<Void> {
        return Promise { seal in
            let body2 = Body2(email: email, password: password)

            DefaultAPI.appHttpControllersAPIUserCreate(body: body2) { [weak self] (data, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                if let data = data,
                    let token = data.token {
                    self?.saveUserData(email: email, password: password, token: token)
                    return seal.fulfill(())
                }
            }
        }

    }

    func loginUser(with email: String, password: String) -> Promise<Void> {
        return Promise { seal in
            let body3 = Body3(email: email, password: password)

            DefaultAPI.appHttpControllersAPIUserAuth(body: body3) { [weak self] (data, error) in
                
                if let error = error {
                    return seal.reject(error)
                }

                if let data = data,
                    let token = data.token {
                    self?.saveUserData(email: email, password: password, token: token)
                    return seal.fulfill(())
                }

            }
        }
    }
    
    // MARK: - Private
    
    private func saveUserData(email: String, password: String, token: String) {
        sessionClient.token = token
        userStorage.saveToken(token)
        userStorage.saveUserCredentials(email: email, password: password)
    }
}
