//
//  Survey.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

// sourcery: AutoEquatable
public struct Survey
{
    let id: String
    let type: String
    let title: String?
    let description: String?
    let coverImageUrl: String?
    let surveyType: String?
    let createdAt: Date?
    let activeAt: Date?
}

extension Survey
{
    static let sample = Survey(id: "270130035d415c1d90bb",
                               type: "survey_simple",
                               title: "Working from home Check-In",
                               description: "We would like to know how you feel about our work from home...",
                               coverImageUrl: "https://ucarecdn.com/ed35738a-31e0-476c-8af3-1cf3dfb92ad9/-/quality/smart_retina/-/format/auto/",
                               surveyType: "Restaurant",
                               createdAt: Date.now.addingTimeInterval(-4 * Date.oneDayTimeInterval),
                               activeAt: Date.now)

    static let samples = [Survey(id: "d5de6a8f8f5f1cfe51bc",
                                 type: "survey_simple",
                                 title: "Scarlett Bangkok",
                                 description: "We'd love to hear from you!",
                                 coverImageUrl: "https://ucarecdn.com/62886578-df8b-4f65-902e-8e88d97748b8/-/quality/smart_retina/-/format/auto/",
                                 surveyType: "Restaurant",
                                 createdAt: Date.now.addingTimeInterval(-4 * Date.oneHourTimeInterval),
                                 activeAt: Date.now),
                          Survey(id: "ed1d4f0ff19a56073a14",
                                 type: "survey_simple",
                                 title: "ibis Bangkok Riverside",
                                 description: "We'd love to hear from you!",
                                 coverImageUrl: "https://ucarecdn.com/e4bc340d-27e8-4698-80f2-91e0e5c91a13/-/quality/smart_retina/-/format/auto/",
                                 surveyType: "Restaurant",
                                 createdAt: Date.now.addingTimeInterval(-1 * Date.oneDayTimeInterval),
                                 activeAt: Date.now),
                          Survey(id: "270130035d415c1d90bb",
                                 type: "survey_simple",
                                 title: "21 on Rajah",
                                 description: "We'd love to hear from you!",
                                 coverImageUrl: "https://ucarecdn.com/ed35738a-31e0-476c-8af3-1cf3dfb92ad9/-/quality/smart_retina/-/format/auto/",
                                 surveyType: "Restaurant",
                                 createdAt: Date.now.addingTimeInterval(-2 * Date.oneDayTimeInterval),
                                 activeAt: Date.now),
                          Survey(id: "a83d91f5518e5c14a8bf",
                                 type: "survey_simple",
                                 title: "Let's Chick",
                                 description: "We'd love ot hear from you!",
                                 coverImageUrl: "https://ucarecdn.com/456f46fe-637c-4ed1-9d6d-67f4fd0f2bde/-/quality/smart_retina/-/format/auto/",
                                 surveyType: "Restaurant",
                                 createdAt: Date.now.addingTimeInterval(-3 * Date.oneDayTimeInterval),
                                 activeAt: Date.now)]
}
