//
//  HomeViewModelSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Nimble
import Quick

@testable import MySurveyChallenge

final class HomeViewModelSpec: AsyncSpec {
    override class func spec() {
        describe("HomeViewModel") {
            var sut: HomeViewModel!
            var getSurveysUseCase: GetSurveysUseCaseMock!
            var authenticationManager: AuthenticationManagerMock!
            var cancellables: Set<AnyCancellable>!

            beforeEach {
                getSurveysUseCase = GetSurveysUseCaseMock()
                authenticationManager = AuthenticationManagerMock()
                sut = HomeViewModel(getSurveysUseCase: getSurveysUseCase, authenticationManager: authenticationManager)
                cancellables = Set<AnyCancellable>()
            }

            afterEach {
                sut = nil
                getSurveysUseCase = nil
                authenticationManager = nil
                cancellables = nil
            }

            describe("fetchSurveys") {
                context("when fetching surveys successfully") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success([Survey.sample])).eraseToAnyPublisher()
                        }
                    }

                    it("should update surveys") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$surveys
                                .sink { value in
                                    expect(value).to(equal([Survey.sample]))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }

                    it("should stop show loading indicator") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$isLoading
                                .sink { value in
                                    expect(value).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when fetching surveys fails with no internet error") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.noInternet)).eraseToAnyPublisher()
                        }
                    }

                    it("should set errorMsg") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$errorMsg
                                .sink { value in
                                    expect(value).to(equal("No internet connection. please check your internet settings"))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }

                    it("should stop show loading indicator") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$isLoading
                                .sink { value in
                                    expect(value).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when fetching surveys fails with other error") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.other(""))).eraseToAnyPublisher()
                        }
                    }

                    it("should set errorMsg") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$errorMsg
                                .sink { value in
                                    expect(value).to(equal("Something went wrong"))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }

                    it("should stop show loading indicator") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$isLoading
                                .sink { value in
                                    expect(value).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when fetching surveys fails with networking error") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.networking(statusCode: nil,
                                                      serverError: nil,
                                                      localizedDescription: nil))).eraseToAnyPublisher()
                        }
                    }

                    it("should set errorMsg") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$errorMsg
                                .sink { value in
                                    expect(value).to(equal("Something went wrong"))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }

                    it("should stop show loading indicator") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$isLoading
                                .sink { value in
                                    expect(value).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when fetching surveys fails with other error") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.other(""))).eraseToAnyPublisher()
                        }
                    }

                    it("should set errorMsg") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$errorMsg
                                .sink { value in
                                    expect(value).to(equal("Something went wrong"))
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }

                    it("should stop show loading indicator") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$isLoading
                                .sink { value in
                                    expect(value).to(beFalse())
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }
            }

            describe("logout") {
                it("should remove credentials") {
                    sut.logout()

                    expect(authenticationManager.removeCredentialsVoidCalled).to(beTrue())
                }
            }
        }
    }
}
