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
    func retrieveStoredToken() async -> UserCredentials?
}

class AuthenticationManagerImpl: AuthenticationManager {
    private(set) var credentials: UserCredentials?
    private let secureStoreService: SecureStoreService

    init(credentials: UserCredentials? = nil,
         secureStoreService: SecureStoreService)
    {
        self.credentials = credentials
        self.secureStoreService = secureStoreService
    }

    func saveCredentials(_ credentials: UserCredentials) {
        self.credentials = credentials
        try? secureStoreService.saveObject(credentials, key: .credentials)
    }

    func retrieveStoredToken() async -> UserCredentials? {
        if let storedUserCredentials: UserCredentials = try? secureStoreService.getObject(.credentials), !storedUserCredentials.isExpired {
            credentials = storedUserCredentials
        }
        return credentials
    }

    func removeCredentials() {
        credentials = nil
        try? secureStoreService.remove(.credentials)
    }

    func isTokenValid() -> Bool {
        if let credentials = credentials {
            return !credentials.isExpired
        }
        return false
    }
}
