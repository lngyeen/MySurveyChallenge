//
//  LoginRepositoryImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class LoginRepositoryImplSpec: QuickSpec {
    override class func spec() {
        describe("LoginRepositoryImpl") {
            var cancellables: Set<AnyCancellable> = []
            var loginDataProviderMock: LoginDataProviderMock!
            var dto: LoginDTO!
            var sut: LoginRepositoryImpl!

            describe("it loginWith") {
                beforeEach {
                    loginDataProviderMock = LoginDataProviderMock()
                    dto = LoginDTO(email: "test@example.com",
                                   password: "password",
                                   clientId: "clientId",
                                   clientSecret: "clientSecret")
                    sut = LoginRepositoryImpl(dataProvider: loginDataProviderMock)
                }

                afterEach {
                    cancellables.removeAll()
                }

                context("when network request succeeds") {
                    beforeEach {
                        loginDataProviderMock.loginWithEmailStringPasswordStringAnyPublisherResultJSONAPIResponseUserCredentialsDTONetworkAPIErrorNeverClosure = { _, _ in
                            Just(.success(JSONAPIResponse(data: UserCredentialsDTO.sample, meta: nil))).eraseToAnyPublisher()
                        }
                    }

                    it("it return value as a UserCredentials") {
                        waitUntil(timeout: .seconds(5)) { done in
                            sut.loginWith(email: dto.email, password: dto.password)
                                .sink { response in
                                    switch response {
                                    case .success:
                                        break
                                    case .failure:
                                        fail("Login should success")
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when network request fails") {
                    beforeEach {
                        loginDataProviderMock.loginWithEmailStringPasswordStringAnyPublisherResultJSONAPIResponseUserCredentialsDTONetworkAPIErrorNeverClosure = { _, _ in
                            Just(.failure(.noInternet)).eraseToAnyPublisher()
                        }
                    }

                    it("it return error") {
                        waitUntil(timeout: .seconds(5)) { done in
                            sut.loginWith(email: dto.email, password: dto.password)
                                .sink { response in
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
