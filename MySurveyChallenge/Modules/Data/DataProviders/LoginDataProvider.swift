//
//  LoginDataProvider.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Alamofire
import Combine
import Foundation

// sourcery: AutoMockable
protocol LoginDataProvider {
    func loginWith(email: String, password: String) -> AnyPublisher<Result<JSONAPIResponse<UserCredentialsDTO>, NetworkAPIError>, Never>
}

final class LoginDataProviderImpl: LoginDataProvider {
    private let networkAPIClient: NetworkAPIClient

    init(networkAPIClient: NetworkAPIClient) {
        self.networkAPIClient = networkAPIClient
    }

    func loginWith(email: String, password: String) -> AnyPublisher<Result<JSONAPIResponse<UserCredentialsDTO>, NetworkAPIError>, Never> {
        let loginDto = LoginDTO(email: email,
                                password: password,
                                clientId: Config.current.clientId,
                                clientSecret: Config.current.clientSecret)
        let configuration = AuthenticationRequestEndpoint.login(loginDto: loginDto)
        return networkAPIClient
            .performRequest(configuration, for: UserCredentialsDTO.self)
            .eraseToAnyPublisher()
    }
}
