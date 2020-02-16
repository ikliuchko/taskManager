//
//  SessionClient.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import SwaggerClient

class SessionClient {
    
    private struct Constants {
        static let authorization = "Authorization"
        static let bearer = "Bearer"
    }

    var token: String? {
        didSet {
            if let formattedToken = formatToken() {
                SwaggerClientAPI.customHeaders[Constants.authorization] = formattedToken
            }
        }
    }

    func formatToken() -> String? {
        guard let token = token else {
            return nil
        }

        return Constants.bearer + " " + token
    }
}
