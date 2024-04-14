//
//  NetworkAPIClientProvider.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Foundation

enum NetworkAPIType {
    case basic
    // Add more types if needed

    func jsonAPIFactory() -> NetworkAPIClientFactory {
        switch self {
        case .basic:
            return BasicNetworkJSONAPIClientFactory()
        }
    }
}

enum NetworkAPIClientProvider {
    private static var networkClients: [NetworkAPIType: NetworkAPIClient] = [:]

    static func clientForType(_ type: NetworkAPIType) -> NetworkAPIClient {
        if let networkClient = networkClients[type] {
            return networkClient
        }

        let networkClient = type.jsonAPIFactory().createNetworkAPIClient()
        networkClients[type] = networkClient
        return networkClient
    }
}
