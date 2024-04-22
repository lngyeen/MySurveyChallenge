//
//  SurveyDataProviderImplSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class SurveyDataProviderImplSpec: QuickSpec {
    override class func spec() {
        describe("SurveyDataProviderImpl") {
            var cancellables: Set<AnyCancellable> = []
            var networkAPIClientMock: NetworkAPIClientMock<[SurveyDTO]>!
            var sut: SurveyDataProviderImpl!

            describe("getSurveys") {
                beforeEach {
                    networkAPIClientMock = NetworkAPIClientMock<[SurveyDTO]>()
                    sut = SurveyDataProviderImpl(networkAPIClient: networkAPIClientMock)
                }

                afterEach {
                    cancellables.removeAll()
                }

                context("when network request succeeds") {
                    beforeEach {
                        networkAPIClientMock.performRequestReturnValue = Just(.success(JSONAPIResponse<[SurveyDTO]>(data: SurveyDTO.samples, meta: nil))).eraseToAnyPublisher()
                    }

                    it("returns success") {
                        waitUntil(timeout: .seconds(5)) { done in
                            sut.getSurveys(pageNumber: 1, pageSize: 10)
                                .sink { response in
                                    switch response {
                                    case .success(let response):
                                        expect(response.data.count).to(equal(SurveyDTO.samples.count))

                                    case .failure:
                                        fail("Fetching surveys should succeed")
                                    }
                                    done()
                                }
                                .store(in: &cancellables)
                        }
                    }
                }

                context("when network request fails") {
                    beforeEach {
                        networkAPIClientMock.performRequestReturnValue = Just(.failure(.noInternet)).eraseToAnyPublisher()
                    }

                    it("returns failure") {
                        waitUntil(timeout: .seconds(5)) { done in
                            sut.getSurveys(pageNumber: 1, pageSize: 10)
                                .sink { response in
                                    switch response {
                                    case .success:
                                        fail("Fetching surveys should fail")

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
