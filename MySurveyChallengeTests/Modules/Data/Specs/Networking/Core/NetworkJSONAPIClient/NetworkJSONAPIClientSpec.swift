//
//  NetworkJSONAPIClientSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class NetworkJSONAPIClientSpec: QuickSpec {
    override class func spec() {
        describe("NetworkJSONAPIClient") {
            var sut: NetworkJSONAPIClient!
            var requestEndpoint: DummyRequestEndpoint!
            var cancellables: Set<AnyCancellable> = []

            describe("its performRequest") {
                beforeEach {
                    sut = NetworkJSONAPIClient()
                }

                afterEach {
                    HTTPRequestStubber.removeAllStubs()
                }

                context("when network return value") {
                    beforeEach {
                        requestEndpoint = DummyRequestEndpoint.test
                        HTTPRequestStubber.stub(requestEndpoint)
                    }

                    it("it return list of DummyJSONAPIDTO") {
                        waitUntil { done in
                            sut.performRequest(
                                requestEndpoint,
                                for: [DummyJSONAPIDTO].self
                            )
                            .sink { response in
                                expect(response.value?.count).to(equal(2))

                                response.value?.forEach { (dto: DummyJSONAPIDTO) in
                                    expect(dto.title).toNot(beNil())
                                    expect(dto.description).toNot(beNil())
                                    expect(dto.coverImageUrl).toNot(beNil())
                                    expect(dto.surveyType).toNot(beNil())
                                    expect(dto.createdAt).toNot(beNil())
                                    expect(dto.activeAt).toNot(beNil())
                                }

                                done()
                            }
                            .store(in: &cancellables)
                        }
                    }
                }

                context("when network return error") {
                    beforeEach {
                        requestEndpoint = DummyRequestEndpoint.test
                        HTTPRequestStubber.stubError(requestEndpoint)
                    }

                    it("it return error") {
                        waitUntil { done in
                            sut.performRequest(
                                requestEndpoint,
                                for: [DummyJSONAPIDTO].self
                            )
                            .sink { response in
                                expect(response.error).toNot(beNil())
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
