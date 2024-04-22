//
//  SurveyRepositoryImpl.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation

final class SurveyRepositoryImpl: SurveyRepository {
    private let dataProvider: SurveyDataProvider

    init(dataProvider: SurveyDataProvider) {
        self.dataProvider = dataProvider
    }

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<NetworkResponse<[Survey]>, AppNetworkError>, Never> {
        return dataProvider
            .getSurveys(pageNumber: pageNumber, pageSize: pageSize)
            .map { response in
                response
                    .map { NetworkResponse(data: $0.data.map { SurveyModelMapper.modelFrom(dto: $0) },
                                           meta: $0.meta?.toNetworkPadingInfo()) }
                    .mapToAppNetworkError()
            }
            .eraseToAnyPublisher()
    }
}
