//
//  RefreshTokenDTO.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Foundation

struct RefreshTokenDTO: Codable {
    let grantType: String = "refresh_token"
    let refreshToken: String
    let clientId: String
    let clientSecret: String

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case refreshToken = "refresh_token"
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
}
