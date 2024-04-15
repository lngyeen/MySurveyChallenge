//
//  AppNetworkErrorMapperSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Alamofire
import Combine
import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class AppNetworkErrorMapperSpec: QuickSpec {
    override class func spec() {
        describe("AppNetworkErrorMapper") {
            describe("perform appNetworkErrorFrom") {
                context("when networkAPIError is networking") {
                    it("it returns correct AppNetworkError") {
                        let networkAPIError = NetworkAPIError.networking(NetworkingError(initialError: AFError.explicitlyCancelled, backendErrors: nil))
                        
                        let appNetworkError = AppNetworkErrorMapper.appNetworkErrorFrom(networkAPIError: networkAPIError)
                        
                        switch appNetworkError {
                        case .networking:
                            break
                        default:
                            fail()
                        }
                    }
                }
                
                context("when networkAPIError is noInternet") {
                    it("it returns correct AppNetworkError") {
                        let networkAPIError = NetworkAPIError.noInternet
                        
                        let appNetworkError = AppNetworkErrorMapper.appNetworkErrorFrom(networkAPIError: networkAPIError)
                        
                        switch appNetworkError {
                        case .noInternet:
                            break
                        default:
                            fail()
                        }
                    }
                }
                
                context("when networkAPIError is unknow") {
                    it("it returns correct AppNetworkError") {
                        let networkAPIError = NetworkAPIError.other("")
                        
                        let appNetworkError = AppNetworkErrorMapper.appNetworkErrorFrom(networkAPIError: networkAPIError)
                        
                        switch appNetworkError {
                        case .other:
                            break
                        default:
                            fail()
                        }
                    }
                }
            }
        }
    }
}
