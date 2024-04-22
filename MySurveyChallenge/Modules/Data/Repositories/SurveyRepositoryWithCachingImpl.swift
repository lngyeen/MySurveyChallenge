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

    private let dataProvider: SurveyDataProvider
    private let localStoreService: LocalStoreService

    init(dataProvider: SurveyDataProvider, localStoreService: LocalStoreService) {
        self.dataProvider = dataProvider
        self.localStoreService = localStoreService
    }

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<NetworkResponse<[Survey]>, AppNetworkError>, Never> {
        return dataProvider
            .getSurveys(pageNumber: pageNumber, pageSize: pageSize)
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .map { [localStoreService] response -> Result<NetworkResponse<[Survey]>, AppNetworkError> in
                switch response {
                case .success(let surveyDTOs):
                    if let jsonData = try? JSONEncoder().encode(surveyDTOs) {
                        try? localStoreService.saveDataToCache(jsonData, fileName: Constants.cachedSurveysFileName)
                    }
                    return response
                        .map { NetworkResponse(data: $0.data.map { SurveyModelMapper.modelFrom(dto: $0) },
                                               meta: $0.meta?.toNetworkPadingInfo()) }
                        .mapToAppNetworkError()

                case .failure(let error):
                    if let cachedSurveysData = try? localStoreService.loadDataFromCache(Constants.cachedSurveysFileName),
                       let cachedSurveys: [SurveyDTO] = try? JSONDecoder().decode([SurveyDTO].self, from: cachedSurveysData)
                    {
                        let surveys = cachedSurveys.map { SurveyModelMapper.modelFrom(dto: $0) }
                        return .success(NetworkResponse(data: surveys, meta: nil))
                    }
                    return .failure(AppNetworkErrorMapper.appNetworkErrorFrom(networkAPIError: error))
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
