//
//  UserRepository.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.03.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import PromiseKit
import SwaggerClient

struct UserRepository {
    
    private let userStorage = UserSecureStorage()
    private let sessionClient = SessionClient()
    
    func loginUser(with email: String, password: String) -> Promise<Void> {
        return Promise { seal in
            let body3 = Body3(email: email, password: password)
            
            DefaultAPI.appHttpControllersAPIUserAuth(body: body3) { (data, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                if let data = data,
                    let token = data.token {
                    self.saveUserData(email: email, password: password, token: token)
                    return seal.fulfill(())
                }
                
            }
        }
    }
    
    func registerUser(with email: String, password: String) -> Promise<Void> {
        return Promise { seal in
            let body2 = Body2(email: email, password: password)

            DefaultAPI.appHttpControllersAPIUserCreate(body: body2) { (data, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                if let data = data,
                    let token = data.token {
                    self.saveUserData(email: email, password: password, token: token)
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
