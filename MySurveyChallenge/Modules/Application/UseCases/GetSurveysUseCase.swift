//
//  GetSurveysUseCase.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation

// sourcery: AutoMockable
public protocol GetSurveysUseCase {
    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<NetworkResponse<[Survey]>, AppNetworkError>, Never>
}

final class GetSurveysUseCaseImpl: GetSurveysUseCase {
    private let surveyRepository: SurveyRepository

    init(surveyRepository: SurveyRepository) {
        self.surveyRepository = surveyRepository
    }

    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<NetworkResponse<[Survey]>, AppNetworkError>, Never>
    {
        return surveyRepository
            .getSurveys(pageNumber: pageNumber, pageSize: pageSize)
    }
}
