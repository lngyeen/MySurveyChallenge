//
//  NetworkAPIClientMock.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Combine
import Foundation

@testable import MySurveyChallenge

class NetworkAPIClientMock<M: Codable>: NetworkAPIClient {
    var performRequestCallsCount = 0
    var performRequestReceivedArguments: [(configuration: RequestEndpoint, type: Any.Type)] = []
    var performRequestReturnValue: AnyPublisher<Result<JSONAPIResponse<M>, NetworkAPIError>, Never>!

    func performRequest<T: Codable>(
        _ configuration: RequestEndpoint,
        for type: T.Type
    ) -> AnyPublisher<Result<JSONAPIResponse<T>, NetworkAPIError>, Never> {
        performRequestCallsCount += 1
        performRequestReceivedArguments.append((configuration: configuration, type: type))
        return performRequestReturnValue as! AnyPublisher<Result<JSONAPIResponse<T>, NetworkAPIError>, Never>
    }
}
