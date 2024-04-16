//
//  SurveyRequestEndpoint.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Alamofire
import Foundation

enum SurveyRequestEndpoint: RequestEndpoint {
    case getSurveys(pageNumber: Int,
                    pageSize: Int)

    var path: String { "/api/v1/surveys" }

    var method: Alamofire.HTTPMethod { .get }

    var encoding: Alamofire.ParameterEncoding { URLEncoding.queryString }

    var parameters: Parameters? {
        switch self {
        case .getSurveys(let pageNumber, let pageSize):
            return ["page[number]": pageNumber,
                    "page[size]": pageSize]
        }
    }

    var interceptor: RequestInterceptor? {
        let authenticationManager = DI.singleton.resolve(AuthenticationManager.self)!
        let authenticator = OAuthAuthenticator(authenticationManager: authenticationManager)
        return AuthenticationInterceptor(authenticator: authenticator,
                                         credential: authenticationManager.credentials)
    }

    var sampleData: Data {
        SurveyDTO.json.data
    }
}
