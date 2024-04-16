//
//  SurveyModelMapperSpec.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Foundation
import Nimble
import Quick

@testable import MySurveyChallenge

final class SurveyModelMapperSpec: QuickSpec {
    override class func spec() {
        describe("SurveyModelMapper") {
            describe("perform modelFrom") {
                it("it returns Survey") {
                    let dto = SurveyDTO(id: "1",
                                        type: "type",
                                        title: "title",
                                        description: "description",
                                        coverImageUrl: "coverImageUrl",
                                        surveyType: "surveyType",
                                        createdAt: Date(),
                                        activeAt: Date())

                    let survey = SurveyModelMapper.modelFrom(dto: dto)

                    expect(survey.id).to(equal("1"))
                    expect(survey.type).to(equal("type"))
                    expect(survey.title).to(equal("title"))
                    expect(survey.description).to(equal("description"))
                    expect(survey.coverImageUrl).to(equal("coverImageUrl"))
                    expect(survey.surveyType).to(equal("surveyType"))
                    expect(survey.createdAt).to(beAKindOf(Date.self))
                    expect(survey.activeAt).to(beAKindOf(Date.self))
                }
            }
        }
    }
}
