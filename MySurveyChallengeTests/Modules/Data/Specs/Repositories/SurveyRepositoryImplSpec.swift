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
            var networkClient: NetworkJSONAPIClient!
            var cancellables: Set<AnyCancellable> = []
            
            describe("it getSurveys") {
                beforeEach {}
                
                afterEach {
                    HTTPRequestStubber.removeAllStubs()
                    DI.singleton.resolve(AuthenticationManager.self)!.removeCredentials()
                    cancellables.removeAll()
                }
                
                context("when network request succeeds with data") {
                    beforeEach {
                        networkClient = NetworkJSONAPIClient()
                        sut = SurveyRepositoryImpl(networkAPIClient: networkClient)
                    }
                    
                    it("it return value as a list of Surveys") {
                        HTTPRequestStubber.stub(SurveyRequestEndpoint.getSurveys(pageNumber: 1, pageSize: 2))
                        DI.singleton.resolve(AuthenticationManager.self)!.saveCredentials(UserCredentials.sample)
                         
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
                        networkClient = NetworkJSONAPIClient()
                        sut = SurveyRepositoryImpl(networkAPIClient: networkClient)
                    }
                    
                    it("it return error") {
                        HTTPRequestStubber.stubError(SurveyRequestEndpoint.getSurveys(pageNumber: 1, pageSize: 2))
                        DI.singleton.resolve(AuthenticationManager.self)!.saveCredentials(UserCredentials.sample)
                         
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
