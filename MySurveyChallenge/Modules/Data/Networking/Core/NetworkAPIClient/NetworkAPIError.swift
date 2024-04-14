//
//  NetworkAPIError.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Foundation

enum NetworkAPIError: Error {
    case networking(_ error: NetworkingError)
    case noInternet
    case other(String)
}

struct NetworkingError: Error {
    let initialError: AFError
    let backendErrors: BackendErrors?

    var statusCode: Int? {
        return initialError.responseCode
    }
}

struct BackendErrors: Codable, Error {
    var errors: [BackendError]
}

struct BackendError: Codable, Error {
    var detail: String
    var code: String
}
