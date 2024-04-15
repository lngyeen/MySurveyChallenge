//
//  LoginRepository.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Combine
import Foundation

// sourcery: AutoMockable
public protocol LoginRepository {
    func loginWith(email: String, password: String) -> AnyPublisher<Result<UserCredentials, AppNetworkError>, Never>
}
