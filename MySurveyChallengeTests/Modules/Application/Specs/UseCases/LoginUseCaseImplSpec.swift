//
//  LoginUseCaseImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class LoginUseCaseImplSpec: QuickSpec {
    override class func spec() {
        describe("LoginUseCaseImpl") {
            var cancellables: Set<AnyCancellable> = []
            var loginRepositoryMock: LoginRepositoryMock!
            var authenticationManagerMock: AuthenticationManagerMock!
            var sut: LoginUseCaseImpl!
            
            describe("it loginWith") {
                beforeEach {
                    loginRepositoryMock = LoginRepositoryMock()
                    authenticationManagerMock = AuthenticationManagerMock()
                    sut = LoginUseCaseImpl(loginRepository: loginRepositoryMock, authenticationManager: authenticationManagerMock)
                }
                
                afterEach {
                    cancellables.removeAll()
                }
                
                context("when login is successful") {
                    let credentials = UserCredentials.sample
                    
                    beforeEach {
                        loginRepositoryMock.loginWithEmailStringPasswordStringAnyPublisherResultUserCredentialsAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(credentials)).eraseToAnyPublisher()
                        }
                    }
                    
                    it("it should save credentials") {
                        sut.loginWith(email: "test@example.com", password: "password")
                            .sink { result in
                                switch result {
                                case .success(let returnedCredentials):
                                    expect(returnedCredentials).to(equal(credentials))
                                case .failure:
                                    fail("Login should be successful")
                                }
                            }
                            .store(in: &cancellables)
                        expect(authenticationManagerMock.saveCredentialsCredentialsUserCredentialsVoidCalled).to(beTrue())
                    }
                }
                
                context("when login fails") {
                    beforeEach {
                        loginRepositoryMock.loginWithEmailStringPasswordStringAnyPublisherResultUserCredentialsAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.networking(statusCode: nil, serverError: nil, localizedDescription: nil))).eraseToAnyPublisher()
                        }
                    }
                    
                    it("it should not save credentials") {
                        sut.loginWith(email: "test@example.com", password: "password")
                            .sink { result in
                                switch result {
                                case .success:
                                    fail("Login should fail")
                                case .failure:
                                    break
                                }
                            }
                            .store(in: &cancellables)
                        expect(authenticationManagerMock.saveCredentialsCredentialsUserCredentialsVoidCalled).to(beFalse())
                    }
                }
            }
        }
    }
}
