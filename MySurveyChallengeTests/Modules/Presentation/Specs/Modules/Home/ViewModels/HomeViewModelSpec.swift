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
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(NetworkResponse(data: [Survey.sample], meta: PagingInfo.sample))).eraseToAnyPublisher()
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

                context("when fetching more surveys in the middle page successfully") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(NetworkResponse(data: Survey.samples,
                                                          meta: PagingInfo(page: 2, pages: 3, pageSize: 4, records: 12)))).eraseToAnyPublisher()
                        }

                        sut.surveys = Survey.samples
                        sut.isLoading = false
                        sut.errorMsg = nil
                    }

                    it("should append new surveys to existing ones") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$surveys
                                .sink { value in
                                    expect(value.count).to(equal(Survey.samples.count * 2))
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

                context("when fetching more surveys in the last page successfully") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(NetworkResponse(data: Survey.samples,
                                                          meta: PagingInfo(page: 2, pages: 2, pageSize: 4, records: 8)))).eraseToAnyPublisher()
                        }

                        sut.surveys = Survey.samples
                        sut.isLoading = false
                        sut.errorMsg = nil
                    }

                    it("should append new surveys to existing ones") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$surveys
                                .sink { value in
                                    expect(value.count).to(equal(Survey.samples.count * 2))
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

                    it("should stop load next pages") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$surveys
                                .sink { value in
                                    expect(value.count).to(equal(Survey.samples.count * 2))
                                    done()
                                }
                                .store(in: &cancellables)
                        }

                        expect(getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverCallsCount).to(equal(1))

                        sut.fetchSurveys()

                        expect(getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverCallsCount).to(equal(1))
                    }
                }

                context("when fetching more surveys successfully but has no meta info") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(NetworkResponse(data: Survey.samples,
                                                          meta: nil))).eraseToAnyPublisher()
                        }

                        sut.surveys = Survey.samples
                        sut.isLoading = false
                        sut.errorMsg = nil
                    }

                    it("should append new surveys to existing ones") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$surveys
                                .sink { value in
                                    expect(value.count).to(equal(Survey.samples.count * 2))
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

                    it("should stop load next pages") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$surveys
                                .sink { value in
                                    expect(value.count).to(equal(Survey.samples.count * 2))
                                    done()
                                }
                                .store(in: &cancellables)
                        }

                        expect(getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverCallsCount).to(equal(1))

                        sut.fetchSurveys()

                        expect(getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverCallsCount).to(equal(1))
                    }
                }

                context("when fetching surveys fails with no internet error") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
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
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
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
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
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

                context("when fetching surveys fails with networking error that has 401 status code") {
                    beforeEach {
                        getSurveysUseCase.getSurveysPageNumberIntPageSizeIntAnyPublisherResultNetworkResponseSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.networking(statusCode: 401,
                                                      serverError: nil,
                                                      localizedDescription: nil))).eraseToAnyPublisher()
                        }
                    }

                    it("should set showAuthenticationAlert") {
                        sut.fetchSurveys()

                        await waitUntil { done in
                            sut.$showAuthenticationAlert
                                .sink { value in
                                    expect(value).to(beTrue())
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
