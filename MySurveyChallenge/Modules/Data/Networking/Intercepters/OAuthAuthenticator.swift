//
//  OAuthAuthenticator.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Alamofire
import Foundation

extension UserCredentials: AuthenticationCredential {
    static var count: Int = 0

    public var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
}

class OAuthAuthenticator: Authenticator {
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }

    private let authenticationManager: AuthenticationManager

    func apply(_ credential: UserCredentials, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    func refresh(_ credential: UserCredentials,
                 for session: Session,
                 completion: @escaping (Result<UserCredentials, Error>) -> Void)
    {
        let refreshTokenDto = UserCredentialsModelMapper.refreshTokenDtoFrom(model: credential)
        let configuration = AuthenticationRequestEndpoint.refreshToken(refreshTokenDto: refreshTokenDto)
        let refreshTokenRequest = session.request(
            configuration.url,
            method: configuration.method,
            parameters: configuration.parameters,
            encoding: configuration.encoding,
            headers: configuration.headers,
            interceptor: configuration.interceptor
        )
        refreshTokenRequest
            .validate()
            .responseCodableJSONAPI(completionHandler: { [authenticationManager]
                (response: DataResponse<JapxResponse<UserCredentialsDTO>, AFError>) in
                if let newCredentialsDto = response.value?.data {
                    let newCredentials = UserCredentialsModelMapper.modelFrom(dto: newCredentialsDto)
                    authenticationManager.saveCredentials(newCredentials)
                    completion(.success(newCredentials))
                } else if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(AFError.explicitlyCancelled))
                }
            })
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool
    {
        return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: UserCredentials) -> Bool {
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
}
