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

    var path: String { "/api/v1/oauth/token" }

    var method: Alamofire.HTTPMethod { .post }

    var encoding: Alamofire.ParameterEncoding { URLEncoding.httpBody }

    var parameters: Parameters? {
        switch self {
        case .login(let loginDto):
            if let data = try? JSONEncoder().encode(loginDto) {
                return try? JSONSerialization.jsonObject(with: data, options: []) as? Parameters
            }
            return nil
        }
    }

    var sampleData: Data {
        UserCredentialsDTO.json.data
    }
}
