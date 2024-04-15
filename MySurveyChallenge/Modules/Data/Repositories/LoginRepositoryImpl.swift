//
//  LoginRepositoryImpl.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Combine
import Foundation

final class LoginRepositoryImpl: LoginRepository {
    private let networkAPIClient: NetworkAPIClient

    init(networkAPIClient: NetworkAPIClient) {
        self.networkAPIClient = networkAPIClient
    }

    func loginWith(email: String, password: String) -> AnyPublisher<Result<UserCredentials, AppNetworkError>, Never> {
        let loginDto = LoginDTO(email: email,
                                password: password,
                                clientId: Config.current.clientId,
                                clientSecret: Config.current.clientSecret)
        let configuration = AuthenticationRequestEndpoint.login(loginDto: loginDto)

        return networkAPIClient
            .performRequest(configuration, for: UserCredentialsDTO.self)
            .map { response in
                response
                    .result
                    .map { UserCredentialsModelMapper.modelFrom(dto: $0) }
                    .mapToAppNetworkError()
            }
            .eraseToAnyPublisher()
    }
}
