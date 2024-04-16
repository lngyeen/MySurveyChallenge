//
//  SurveyRepositoryWithCachingImpl.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/17/24.
//

import Combine
import Foundation

final class SurveyRepositoryWithCachingImpl: SurveyRepository {
    enum Constants {
        static let cachedSurveysFileName: String = "cachedSurveys.json"
    }

    private let networkAPIClient: NetworkAPIClient
    private let localStoreService: LocalStoreService

    init(networkAPIClient: NetworkAPIClient, localStoreService: LocalStoreService) {
        self.networkAPIClient = networkAPIClient
        self.localStoreService = localStoreService
    }

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<[Survey], AppNetworkError>, Never> {
        let configuration = SurveyRequestEndpoint.getSurveys(pageNumber: pageNumber, pageSize: pageSize)

        return networkAPIClient
            .performRequest(configuration, for: [SurveyDTO].self)
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .map { [localStoreService] response -> Result<[Survey], AppNetworkError> in
                let result = response.result
                switch result {
                case .success(let surveyDTOs):
                    if let jsonData = try? JSONEncoder().encode(surveyDTOs) {
                        try? localStoreService.saveDataToCache(jsonData, fileName: Constants.cachedSurveysFileName)
                    }
                    return result
                        .map { $0.map { SurveyModelMapper.modelFrom(dto: $0) } }
                        .mapToAppNetworkError()

                case .failure(let error):
                    if let cachedSurveysData = try? localStoreService.loadDataFromCache(Constants.cachedSurveysFileName),
                       let cachedSurveys: [SurveyDTO] = try? JSONDecoder().decode([SurveyDTO].self, from: cachedSurveysData)
                    {
                        let surveys = cachedSurveys.map { SurveyModelMapper.modelFrom(dto: $0) }
                        return .success(surveys)
                    }
                    return .failure(AppNetworkErrorMapper.appNetworkErrorFrom(networkAPIError: error))
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
