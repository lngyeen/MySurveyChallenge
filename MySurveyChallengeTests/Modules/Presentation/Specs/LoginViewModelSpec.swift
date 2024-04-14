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
        var sut: LoginViewModel!
        var cancellables: Set<AnyCancellable> = []

        describe("LoginViewModel") {
            beforeEach {
                sut = LoginViewModel()
            }

            afterEach {
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
        }
    }
}
