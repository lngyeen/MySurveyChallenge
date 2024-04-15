//
//  AppNetworkErrorMapper.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Japx

enum AppNetworkErrorMapper {
    static func appNetworkErrorFrom(networkAPIError: NetworkAPIError) -> AppNetworkError {
        switch networkAPIError {
        case .networking(let error):
            return .networking(statusCode: error.statusCode,
                               serverError: error.backendErrors?.errors.first?.asServerError(),
                               localizedDescription: error.localizedDescription)
        case .noInternet:
            return .noInternet
        case .other(let string):
            return .other(string)
        }
    }
}

extension BackendError {
    func asServerError() -> ServerError {
        return ServerError(code: code, detail: detail)
    }
}
