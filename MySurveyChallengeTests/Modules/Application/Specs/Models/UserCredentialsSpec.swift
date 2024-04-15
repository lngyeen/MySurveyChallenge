//
//  UserCredentialsSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class UserCredentialsSpec: QuickSpec {
    override class func spec() {
        describe("UserCredentials") {
            var sut: UserCredentials!
            var createdAt: TimeInterval!
            var expiresIn: TimeInterval!

            beforeEach {
                createdAt = Date.now.timeIntervalSince1970
                expiresIn = 7200
            }

            context("when accessing properties") {
                beforeEach {
                    sut = UserCredentials(accessToken: "accessToken",
                                          tokenType: "tokenType",
                                          expiresIn: expiresIn,
                                          refreshToken: "refreshToken",
                                          createdAt: createdAt)
                }

                it("should calculate expiration date correctly") {
                    let expirationDate = Date(timeIntervalSince1970: createdAt + expiresIn)
                    expect(sut.expiration).to(equal(expirationDate))
                }
            }

            context("when checking expiration status") {
                beforeEach {
                    sut = UserCredentials(accessToken: "accessToken",
                                          tokenType: "tokenType",
                                          expiresIn: expiresIn,
                                          refreshToken: "refreshToken",
                                          createdAt: createdAt)
                }

                it("should return false if expiration date is in the future") {
                    expect(sut.isExpired).to(beFalse())
                }
            }

            context("when checking expiration status") {
                beforeEach {
                    sut = UserCredentials(accessToken: "accessToken",
                                          tokenType: "tokenType",
                                          expiresIn: expiresIn,
                                          refreshToken: "refreshToken",
                                          createdAt: createdAt - expiresIn)
                }

                it("should return true if expiration date is in the past") {
                    expect(sut.isExpired).to(beTrue())
                }
            }
        }
    }
}
