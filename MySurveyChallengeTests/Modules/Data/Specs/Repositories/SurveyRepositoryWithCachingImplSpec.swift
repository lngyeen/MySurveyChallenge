//
//  SurveyRepositoryWithCachingImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/17/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class SurveyRepositoryWithCachingImplSpec: QuickSpec {
    override class func spec() {
        describe("SurveyRepositoryWithCachingImpl") {
            var sut: SurveyRepositoryWithCachingImpl!
            var surveyDataProviderMock: SurveyDataProviderMock!
            var localStoreServiceMock: LocalStoreServiceMock!
            var cancellables: Set<AnyCancellable> = []

            beforeEach {
                surveyDataProviderMock = SurveyDataProviderMock()
                localStoreServiceMock = LocalStoreServiceMock()
                sut = SurveyRepositoryWithCachingImpl(dataProvider: surveyDataProviderMock, localStoreService: localStoreServiceMock)
            }

            afterEach {
                cancellables.removeAll()
            }

            describe("getSurveys") {
                context("when network request succeeds with data") {
                    beforeEach {
                        surveyDataProviderMock.getSurveysPageNumberIntPageSizeIntAnyPublisherResultJSONAPIResponseSurveyDTONetworkAPIErrorNeverClosure = { _, _ in
                            Just(.success(JSONAPIResponse(data: SurveyDTO.samples, meta: nil))).eraseToAnyPublisher()
                        }
                    }

                    it("it return value as a list of Surveys") {
                        waitUntil { done in
                            sut.getSurveys(pageNumber: 1, pageSize: 2)
                                .sink { response in
                                    switch response {
                                    case .success(let success):
                                        print(success)
                                    case .failure(let error):
                                        print(error)
                                        fail("Get surveys success")
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when network request fails") {
                    beforeEach {
                        surveyDataProviderMock.getSurveysPageNumberIntPageSizeIntAnyPublisherResultJSONAPIResponseSurveyDTONetworkAPIErrorNeverClosure = { _, _ in
                            Just(.failure(.noInternet)).eraseToAnyPublisher()
                        }
                    }

                    it("returns cached survey data when cached data exists") {
                        localStoreServiceMock.loadDataFromCacheFileNameStringDataClosure = { _ in
                            let jsonData = try? JSONEncoder().encode(SurveyDTO.samples)
                            return jsonData
                        }

                        waitUntil { done in
                            sut.getSurveys(pageNumber: 1, pageSize: 2)
                                .sink { response in
                                    switch response {
                                    case .success:
                                        break
                                    case .failure:
                                        fail("Expected failure")
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }

                        expect(localStoreServiceMock.loadDataFromCacheFileNameStringDataCalled).to(beTrue())
                        expect(localStoreServiceMock.loadDataFromCacheFileNameStringDataReceivedFileName).to(equal(SurveyRepositoryWithCachingImpl.Constants.cachedSurveysFileName))
                    }

                    it("returns error when cached data does not exist") {
                        localStoreServiceMock.loadDataFromCacheFileNameStringDataThrowableError = ""

                        waitUntil { done in
                            sut.getSurveys(pageNumber: 1, pageSize: 2)
                                .sink { response in
                                    switch response {
                                    case .success:
                                        fail("Expected failure")
                                    case .failure:
                                        break
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }

                        expect(localStoreServiceMock.loadDataFromCacheFileNameStringDataCalled).to(beTrue())
                        expect(localStoreServiceMock.loadDataFromCacheFileNameStringDataReceivedFileName).to(equal(SurveyRepositoryWithCachingImpl.Constants.cachedSurveysFileName))
                    }
                }
            }
        }
    }
}
