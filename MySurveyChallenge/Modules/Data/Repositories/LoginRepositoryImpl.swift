//
//  LoginRepositoryImpl.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Combine
import Foundation

final class LoginRepositoryImpl: LoginRepository {
    private let dataProvider: LoginDataProvider

    init(dataProvider: LoginDataProvider) {
        self.dataProvider = dataProvider
    }

    func loginWith(email: String, password: String) -> AnyPublisher<Result<UserCredentials, AppNetworkError>, Never> {
        return dataProvider
            .loginWith(email: email, password: password)
            .map { response in
                response
                    .map { UserCredentialsModelMapper.modelFrom(dto: $0.data) }
                    .mapToAppNetworkError()
            }
            .eraseToAnyPublisher()
    }
}
