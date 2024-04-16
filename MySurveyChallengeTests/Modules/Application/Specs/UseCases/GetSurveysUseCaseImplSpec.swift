//
//  GetSurveysUseCaseImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class GetSurveysUseCaseImplSpec: QuickSpec {
    override class func spec() {
        describe("GetSurveysUseCaseImpl") {
            var sut: GetSurveysUseCaseImpl!
            var surveyRepositoryMock: SurveyRepositoryMock!
            var cancellables: Set<AnyCancellable> = []

            describe("it getSurveys") {
                beforeEach {
                    surveyRepositoryMock = SurveyRepositoryMock()
                    sut = GetSurveysUseCaseImpl(surveyRepository: surveyRepositoryMock)
                }

                afterEach {
                    cancellables.removeAll()
                }

                context("when surveys are successfully retrieved") {
                    let surveys = [Survey.sample]

                    beforeEach {
                        surveyRepositoryMock.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.success(surveys)).eraseToAnyPublisher()
                        }
                    }

                    it("should successfully retrieve surveys") {
                        sut.getSurveys(pageNumber: 1, pageSize: 10)
                            .sink { result in
                                switch result {
                                case .success(let receivedSurveys):
                                    expect(receivedSurveys).to(equal(surveys))
                                case .failure:
                                    fail("Retrieving surveys should be successful")
                                }
                            }
                            .store(in: &cancellables)

                        expect(surveyRepositoryMock.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverCalled).to(beTrue())
                    }
                }

                context("when retrieving surveys fails") {
                    beforeEach {
                        surveyRepositoryMock.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverClosure = { _, _ in
                            Just(.failure(.networking(statusCode: nil, serverError: nil, localizedDescription: nil))).eraseToAnyPublisher()
                        }
                    }

                    it("should not successfully retrieve surveys") {
                        sut.getSurveys(pageNumber: 1, pageSize: 10)
                            .sink { result in
                                switch result {
                                case .success:
                                    fail("Retrieving surveys should fail")
                                case .failure:
                                    break
                                }
                            }
                            .store(in: &cancellables)

                        expect(surveyRepositoryMock.getSurveysPageNumberIntPageSizeIntAnyPublisherResultSurveyAppNetworkErrorNeverCalled).to(beTrue())
                    }
                }
            }
        }
    }
}
