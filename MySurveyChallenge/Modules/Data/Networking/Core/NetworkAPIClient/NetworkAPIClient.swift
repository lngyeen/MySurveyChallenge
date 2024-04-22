//
//  NetworkAPIClient.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Combine
import Foundation

protocol NetworkAPIClient {
    func performRequest<T: Codable>(
        _ configuration: RequestEndpoint,
        for type: T.Type
    ) -> AnyPublisher<DataResponse<JSONAPIResponse<T>, NetworkAPIError>, Never>
}
