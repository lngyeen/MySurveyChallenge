//
//  SurveyRepository.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation

// sourcery: AutoMockable
public protocol SurveyRepository {
    func getSurveys(pageNumber: Int, pageSize: Int) -> AnyPublisher<Result<NetworkResponse<[Survey]>, AppNetworkError>, Never>
}
