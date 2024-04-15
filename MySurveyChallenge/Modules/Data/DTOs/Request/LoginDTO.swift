//
//  LoginDTO.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

struct LoginDTO: Codable {
    let grantType: String = "password"
    let email: String
    let password: String
    let clientId: String
    let clientSecret: String

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case email
        case password
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
}
