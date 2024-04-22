//
//  SurveyRepositoryImpl.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation

final class SurveyRepositoryImpl: SurveyRepository {
    private let networkAPIClient: NetworkAPIClient

    init(networkAPIClient: NetworkAPIClient) {
        self.networkAPIClient = networkAPIClient
    }

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<NetworkResponse<[Survey]>, AppNetworkError>, Never> {
        let configuration = SurveyRequestEndpoint.getSurveys(pageNumber: pageNumber, pageSize: pageSize)
        return networkAPIClient
            .performRequest(configuration, for: [SurveyDTO].self)
            .map { response in
                response
                    .result
                    .map { NetworkResponse(data: $0.data.map { SurveyModelMapper.modelFrom(dto: $0) },
                                           meta: $0.meta?.toNetworkPadingInfo()) }
                    .mapToAppNetworkError()
            }
            .eraseToAnyPublisher()
    }
}
