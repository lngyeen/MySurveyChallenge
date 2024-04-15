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
            var networkClient: NetworkJSONAPIClient!
            var dto: LoginDTO!
            var sut: LoginRepositoryImpl!

            describe("it loginWith") {
                beforeEach {
                    dto = LoginDTO(email: "test@example.com",
                                   password: "password",
                                   clientId: "clientId",
                                   clientSecret: "clientSecret")
                }

                afterEach {
                    HTTPRequestStubber.removeAllStubs()
                    cancellables.removeAll()
                }

                context("when network return value") {
                    beforeEach {
                        networkClient = NetworkJSONAPIClient()
                        sut = LoginRepositoryImpl(networkAPIClient: networkClient)
                    }

                    it("it return value as a UserCredentials") {
                        let configuration = AuthenticationRequestEndpoint.login(loginDto: dto)
                        HTTPRequestStubber.stub(configuration)

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

                context("when network return error") {
                    beforeEach {
                        networkClient = NetworkJSONAPIClient()
                        sut = LoginRepositoryImpl(networkAPIClient: networkClient)
                    }

                    it("it return error") {
                        let configuration = AuthenticationRequestEndpoint.login(loginDto: dto)
                        HTTPRequestStubber.stubError(configuration)

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
