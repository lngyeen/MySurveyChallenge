//
//  RequestEndpoint.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Foundation

protocol RequestEndpoint {
    var baseURL: String { get }

    var path: String { get }

    var method: HTTPMethod { get }

    var headers: HTTPHeaders? { get }

    var url: URLConvertible { get }

    var parameters: Parameters? { get }

    var encoding: ParameterEncoding { get }

    var interceptor: RequestInterceptor? { get }

    var sampleData: Data { get }
}

extension RequestEndpoint {
    var baseURL: String { Config.current.baseHost }

    var url: URLConvertible {
        if let url = URL(string: baseURL) {
            return url.appendingPathComponent(path)
        } else {
            fatalError("Invalid baseURL: \(baseURL)")
        }
    }

    var headers: HTTPHeaders? { nil }

    var parameters: Parameters? { nil }

    var encoding: Alamofire.ParameterEncoding { URLEncoding.queryString }

    var interceptor: RequestInterceptor? { nil }

    var sampleData: Data { return Data() }
}
