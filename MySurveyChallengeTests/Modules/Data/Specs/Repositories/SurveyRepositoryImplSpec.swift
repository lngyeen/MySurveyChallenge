//
//  SurveyRepositoryImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class SurveyRepositoryImplSpec: QuickSpec {
    override class func spec() {
        describe("SurveyRepositoryImpl") {
            var sut: SurveyRepositoryImpl!
            var surveyDataProviderMock: SurveyDataProviderMock!
            var cancellables: Set<AnyCancellable> = []
            
            describe("it getSurveys") {
                beforeEach {
                    surveyDataProviderMock = SurveyDataProviderMock()
                    sut = SurveyRepositoryImpl(dataProvider: surveyDataProviderMock)
                }
                
                afterEach {
                    cancellables.removeAll()
                }
                
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
                                    case .success:
                                        break
                                    case .failure:
                                        fail("Get surveys should success")
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
                    
                    it("it return error") {
                        waitUntil { done in
                            sut.getSurveys(pageNumber: 1, pageSize: 2)
                                .sink { response in
                                    switch response {
                                    case .success:
                                        fail("Get surveys should fail")
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
