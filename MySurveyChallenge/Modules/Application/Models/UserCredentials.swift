//
//  UserCredentials.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

// sourcery: AutoEquatable
public struct UserCredentials: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Double
    let refreshToken: String
    let createdAt: Double

    var expiration: Date {
        return Date(timeIntervalSince1970: createdAt + expiresIn)
    }

    var isExpired: Bool {
        return Date.now > expiration
    }
}

extension UserCredentials {
    static let sample = UserCredentials(accessToken: "FJxtYiGoDYdq2emXlFZ65kbZjyfx-BkEDinh3wbWWGg",
                                        tokenType: "Bearer",
                                        expiresIn: 7200,
                                        refreshToken: "GLJNzdoKis99ONNB7MwSCWP1wES0w_kjxG1bBnHv8q4",
                                        createdAt: Date.now.timeIntervalSince1970)
}
