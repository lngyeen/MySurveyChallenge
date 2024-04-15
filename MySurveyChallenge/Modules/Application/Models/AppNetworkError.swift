//
//  AppNetworkError.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

public enum AppNetworkError: Error {
    case networking(statusCode: Int?, serverError: ServerError?, localizedDescription: String?)
    case noInternet
    case other(String)
}

public struct ServerError {
    let code: String
    let detail: String

    var localizedDescription: String {
        return detail
    }
}
