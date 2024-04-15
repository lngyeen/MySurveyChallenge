//
//  SurveyUIModelMapperSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class SurveyUIModelMapperSpec: QuickSpec {
    override class func spec() {
        describe("SurveyUIModelMapper") {
            describe("perform uiModelFrom") {
                it("it returns SurveyUIModel") {
                    let survey = Survey(id: "1",
                                        type: "type",
                                        title: "title",
                                        description: "description",
                                        coverImageUrl: "coverImageUrl",
                                        surveyType: "surveyType",
                                        createdAt: Date(),
                                        activeAt: Date())

                    let surveyUIModel = SurveyUIModelMapper.uiModelFrom(model: survey)

                    expect(surveyUIModel.title).to(equal("title"))
                    expect(surveyUIModel.description).to(equal("description"))
                    expect(surveyUIModel.coverImageUrl).to(equal("coverImageUrl"))
                    expect(surveyUIModel.createdAt).to(beAKindOf(Date.self))
                    expect(surveyUIModel.activeAt).to(beAKindOf(Date.self))
                }
            }
        }
    }
}
