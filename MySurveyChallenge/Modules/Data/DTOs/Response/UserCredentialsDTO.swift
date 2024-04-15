//
//  UserCredentialsDTO.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Japx

struct UserCredentialsDTO: JapxCodable {
    let id: String
    let type: String
    let accessToken: String
    let tokenType: String
    let expiresIn: Double
    let refreshToken: String
    let createdAt: Double

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}

extension UserCredentialsDTO {
    static let json =
        """
        {
            "data": {
                "id": "32461",
                "type": "token",
                "attributes": {
                    "access_token": "sWVatcRXfkaqZr0ctFRalGAUP68mLirkZqcTfrbJ0bk",
                    "token_type": "Bearer",
                    "expires_in": 7200,
                    "refresh_token": "Q26yRCh087reGXycTCzzwUBmmgbe7MRcCV9YfAirH7w",
                    "created_at": 1712889598
                }
            }
        }
        """
}
