//
//  LoginViewModelSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Combine
import Nimble
import Quick

@testable import MySurveyChallenge

final class LoginViewModelSpec: AsyncSpec {
    override class func spec() {
        describe("LoginViewModel") {
            var sut: LoginViewModel!
            var loginUseCase: LoginUseCaseMock!
            var authenticationManager: AuthenticationManagerMock!
            var cancellables: Set<AnyCancellable> = []

            beforeEach {
                loginUseCase = LoginUseCaseMock()
                authenticationManager = AuthenticationManagerMock()
                sut = LoginViewModel(loginUseCase: loginUseCase, authenticationManager: authenticationManager)
            }

            afterEach {
                loginUseCase = nil
                authenticationManager = nil
                sut = nil
                cancellables.removeAll()
            }

            describe("loginButtonEnabled") {
                context("when username and password are not empty") {
                    beforeEach {
                        sut.username = "username"
                        sut.password = "password"
                    }

                    it("should enable the login button") {
                        await waitUntil { done in
                            sut.$loginButtonEnabled
                                .sink { response in
                                    expect(response).to(beTrue())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when username is empty") {
                    beforeEach {
                        sut.username = ""
                        sut.password = "password"
                    }

                    it("should disable the login button") {
                        await waitUntil { done in
                            sut.$loginButtonEnabled
                                .sink { response in
                                    expect(response).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when password is empty") {
                    beforeEach {
                        sut.username = "username"
                        sut.password = ""
                    }

                    it("should disable the login button") {
                        await waitUntil { done in
                            sut.$loginButtonEnabled
                                .sink { response in
                                    expect(response).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }
            }

            describe("perform login") {
                context("when login is successful") {
                    beforeEach {
                        sut.username = "username"
                        sut.password = "password"
                        loginUseCase.loginWithEmailStringPasswordStringAnyPublisherResultUserCredentialsAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(UserCredentials.sample)).eraseToAnyPublisher()
                        }
                    }

                    it("should set loggedIn to true") {
                        sut.login()

                        await waitUntil { done in
                            sut.$loggedIn
                                .sink { value in
                                    expect(value).to(beTrue())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when login fails because no internet error") {
                    beforeEach {
                        sut.username = "username"
                        sut.password = "password"
                        loginUseCase.loginWithEmailStringPasswordStringAnyPublisherResultUserCredentialsAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.noInternet)).eraseToAnyPublisher()
                        }
                    }

                    it("should set loginErrorMsg") {
                        sut.login()

                        await waitUntil { done in
                            sut.$loginErrorMsg
                                .sink { value in
                                    expect(value).to(equal("No internet connection"))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when login fails because networking error") {
                    beforeEach {
                        sut.username = "username"
                        sut.password = "password"
                        loginUseCase.loginWithEmailStringPasswordStringAnyPublisherResultUserCredentialsAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.networking(statusCode: nil, serverError: nil, localizedDescription: nil))).eraseToAnyPublisher()
                        }
                    }

                    it("should set loginErrorMsg") {
                        sut.login()

                        await waitUntil { done in
                            sut.$loginErrorMsg
                                .sink { value in
                                    expect(value).to(equal("Something went wrong"))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when login fails because other error") {
                    beforeEach {
                        sut.username = "username"
                        sut.password = "password"
                        loginUseCase.loginWithEmailStringPasswordStringAnyPublisherResultUserCredentialsAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.other(""))).eraseToAnyPublisher()
                        }
                    }

                    it("should set loginErrorMsg") {
                        sut.login()

                        await waitUntil { done in
                            sut.$loginErrorMsg
                                .sink { value in
                                    expect(value).to(equal("Something went wrong"))
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
