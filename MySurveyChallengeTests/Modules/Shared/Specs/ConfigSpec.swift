//
//  ConfigSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class ConfigSpec: QuickSpec {
    override class func spec() {
        describe("Config") {
            var sut: Config!
            
            context("when accessing properties") {
                beforeEach {
                    sut = Config.current
                }
                
                it("should have non-empty scheme") {
                    expect(sut.scheme.isEmpty).to(beFalse())
                }
                
                it("should have non-empty host") {
                    expect(sut.host.isEmpty).to(beFalse())
                }
                
                it("should have non-empty clientId") {
                    expect(sut.clientId.isEmpty).to(beFalse())
                }
                
                it("should have non-empty clientSecret") {
                    expect(sut.clientSecret.isEmpty).to(beFalse())
                }
                
                it("should construct baseHost correctly") {
                    let expectedBaseHost = "\(sut.scheme)://\(sut.host)"
                    expect(sut.baseHost).to(equal(expectedBaseHost))
                }
            }
        }
    }
}
