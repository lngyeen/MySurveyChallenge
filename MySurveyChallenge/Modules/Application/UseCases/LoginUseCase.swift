//
//  LoginUseCase.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Combine
import Foundation

// sourcery: AutoMockable
public protocol LoginUseCase {
    func loginWith(email: String, password: String) -> AnyPublisher<Result<UserCredentials, AppNetworkError>, Never>
}

final class LoginUseCaseImpl: LoginUseCase {
    private let loginRepository: LoginRepository
    private let authenticationManager: AuthenticationManager

    init(loginRepository: LoginRepository,
         authenticationManager: AuthenticationManager)
    {
        self.loginRepository = loginRepository
        self.authenticationManager = authenticationManager
    }

    func loginWith(email: String, password: String) -> AnyPublisher<Result<UserCredentials, AppNetworkError>, Never>
    {
        return loginRepository
            .loginWith(email: email, password: password)
            .handleEvents(receiveOutput: { [authenticationManager] result in
                switch result {
                case .success(let userCredentials):
                    authenticationManager.saveCredentials(userCredentials)
                case .failure:
                    break
                }
            })
            .eraseToAnyPublisher()
    }
}
