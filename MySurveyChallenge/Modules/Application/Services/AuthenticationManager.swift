//
//  AuthenticationManager.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

// sourcery: AutoMockable
public protocol AuthenticationManager {
    var credentials: UserCredentials? { get }
    func saveCredentials(_ credentials: UserCredentials)
    func removeCredentials()
    func isTokenValid() -> Bool
}

class AuthenticationManagerImpl: AuthenticationManager {
    private(set) var credentials: UserCredentials?

    init(credentials: UserCredentials? = nil) {
        self.credentials = credentials
    }

    func saveCredentials(_ credentials: UserCredentials) {
        self.credentials = credentials
    }

    func removeCredentials() {
        credentials = nil
    }

    func isTokenValid() -> Bool {
        if let credentials = credentials {
            return !credentials.isExpired
        }
        return false
    }
}
