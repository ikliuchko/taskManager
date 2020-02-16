//
//  UserSecureStorage.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation
import KeychainAccess

class UserSecureStorage {
    
    private struct Constants {
        static let authTokenKey = "AuthTokenKey"
        static let emailKey = "emailKey"
        static let passwordKey = "passwordKey"
    }
    
    private let keychain = Keychain()
    
    
//    func resetAuthToken() {
//        try? Keychain().remove(Constants.authTokenKey)
//    }
    
    // MARK: - Public
    
    /// returns latest saved token if available
    func getToken() -> String? {
        return getString(with: Constants.authTokenKey)
    }
    
    /// saves token to Keychain
    func saveToken(_ token: String) {
        keychain[Constants.authTokenKey] = token
    }
    
    /// saves user credentials for refreshing a token
    func saveUserCredentials(email: String, password: String) {
        keychain[Constants.emailKey] = email
        keychain[Constants.passwordKey] = password
    }
    
    /// returns user credentials for re-login if available
    func getUserCreadentials() -> (email: String, password: String)? {
        guard let email = getString(with: Constants.emailKey),
            let pass = getString(with: Constants.passwordKey) else { return nil }
        return (email: email, password: pass)
    }
    
    // MARK: - Private
    
    private func getString(with key: String) -> String? {
        do {
            return try keychain.getString(key)
        } catch {
            return nil
        }
    }
}
