//
//  SurveyDataProvider.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Alamofire
import Combine
import Foundation

// sourcery: AutoMockable
protocol SurveyDataProvider {
    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<JSONAPIResponse<[SurveyDTO]>, NetworkAPIError>, Never>
}

final class SurveyDataProviderImpl: SurveyDataProvider {
    private let networkAPIClient: NetworkAPIClient

    init(networkAPIClient: NetworkAPIClient) {
        self.networkAPIClient = networkAPIClient
    }

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<JSONAPIResponse<[SurveyDTO]>, NetworkAPIError>, Never> {
        let configuration = SurveyRequestEndpoint.getSurveys(pageNumber: pageNumber, pageSize: pageSize)
        return networkAPIClient
            .performRequest(configuration, for: [SurveyDTO].self)
            .eraseToAnyPublisher()
    }
}
