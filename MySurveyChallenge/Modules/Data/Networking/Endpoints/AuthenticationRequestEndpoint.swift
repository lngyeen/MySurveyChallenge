//
//  AuthenticationRequestEndpoint.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Alamofire
import Foundation

enum AuthenticationRequestEndpoint: RequestEndpoint {
    case login(loginDto: LoginDTO)
    case refreshToken(refreshTokenDto: RefreshTokenDTO)

    var path: String { "/api/v1/oauth/token" }

    var method: Alamofire.HTTPMethod { .post }

    var encoding: Alamofire.ParameterEncoding { URLEncoding.httpBody }

    var parameters: Parameters? {
        switch self {
        case .login(let loginDto):
            return encodeToParameters(dto: loginDto)
        case .refreshToken(let refreshTokenDto):
            return encodeToParameters(dto: refreshTokenDto)
        }
    }

    var sampleData: Data {
        UserCredentialsDTO.json.data
    }

    private func encodeToParameters<T: Encodable>(dto: T) -> Parameters? {
        do {
            let data = try JSONEncoder().encode(dto)
            return try JSONSerialization.jsonObject(with: data, options: []) as? Parameters
        } catch {
            return nil
        }
    }
}
