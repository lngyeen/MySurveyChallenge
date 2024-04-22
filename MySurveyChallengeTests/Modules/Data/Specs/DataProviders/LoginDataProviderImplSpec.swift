//
//  LoginDataProviderImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class LoginDataProviderImplSpec: QuickSpec {
    override class func spec() {
        describe("LoginDataProviderImpl") {
            var cancellables: Set<AnyCancellable> = []
            var networkAPIClientMock: NetworkAPIClientMock<UserCredentialsDTO>!
            var dto: LoginDTO!
            var sut: LoginDataProviderImpl!

            describe("loginWith") {
                beforeEach {
                    networkAPIClientMock = NetworkAPIClientMock()
                    dto = LoginDTO(email: "test@example.com",
                                   password: "password",
                                   clientId: "clientId",
                                   clientSecret: "clientSecret")
                    sut = LoginDataProviderImpl(networkAPIClient: networkAPIClientMock)
                }

                afterEach {
                    cancellables.removeAll()
                }

                context("when network request succeeds") {
                    beforeEach {
                        networkAPIClientMock.performRequestReturnValue = Just(.success(JSONAPIResponse<UserCredentialsDTO>(data: UserCredentialsDTO.sample, meta: nil))).eraseToAnyPublisher()
                    }

                    it("returns success") {
                        waitUntil(timeout: .seconds(5)) { done in
                            sut.loginWith(email: dto.email, password: dto.password)
                                .sink { response in
                                    expect(networkAPIClientMock.performRequestCallsCount).to(equal(1))

                                    switch response {
                                    case .success(let response):
                                        expect(response.data.id).to(equal(UserCredentialsDTO.sample.id))
                                        expect(response.data.type).to(equal(UserCredentialsDTO.sample.type))
                                        expect(response.data.accessToken).to(equal(UserCredentialsDTO.sample.accessToken))
                                        expect(response.data.tokenType).to(equal(UserCredentialsDTO.sample.tokenType))
                                        expect(response.data.expiresIn).to(equal(UserCredentialsDTO.sample.expiresIn))
                                        expect(response.data.refreshToken).to(equal(UserCredentialsDTO.sample.refreshToken))
                                        expect(response.data.createdAt).to(equal(UserCredentialsDTO.sample.createdAt))

                                    case .failure:
                                        fail("Login should succeed")
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when network request fails") {
                    beforeEach {
                        networkAPIClientMock.performRequestReturnValue = Just(.failure(.noInternet)).eraseToAnyPublisher()
                    }

                    it("returns failure") {
                        waitUntil(timeout: .seconds(5)) { done in
                            sut.loginWith(email: dto.email, password: dto.password)
                                .sink { response in
                                    expect(networkAPIClientMock.performRequestCallsCount).to(equal(1))

                                    switch response {
                                    case .success:
                                        fail("Login should fail")

                                    case .failure:
                                        break
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }
            }
        }
    }
}
