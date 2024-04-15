//
//  SurveyUIModelSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class SurveyUIModelSpec: QuickSpec {
    override class func spec() {
        describe("SurveyUIModel") {
            var sut: SurveyUIModel!

            beforeEach {
                sut = SurveyUIModel(
                    title: "Sample Title",
                    description: "Sample Description",
                    coverImageUrl: "https://example.com/sample-image.png",
                    createdAt: Date(),
                    activeAt: Date()
                )
            }

            context("when accessing properties") {
                it("createdAtString should return formatted createdAt") {
                    let formattedCreatedAt = sut.createdAt?.formatRelativeWeekdayTime.uppercased() ?? ""
                    expect(sut.createdAtString).to(equal(formattedCreatedAt))
                }

                it("activeAtString should return formatted activeAt") {
                    let formattedActiveAt = sut.activeAt?.formatRelativeWeekdayTime ?? ""
                    expect(sut.activeAtString).to(equal(formattedActiveAt))
                }
            }
        }
    }
}
