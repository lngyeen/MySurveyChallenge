//
//  NetworkAPIClientFactory.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Foundation

protocol NetworkAPIClientFactory {
    func createNetworkAPIClient() -> NetworkAPIClient
}

final class BasicNetworkJSONAPIClientFactory: NetworkAPIClientFactory {
    func createNetworkAPIClient() -> NetworkAPIClient {
        #if DEBUG
        let session = Session(eventMonitors: [ConsoleLogEventMonitor()])
        #else
        let session = Session.default
        #endif
        return NetworkJSONAPIClient(session: session)
    }
}
