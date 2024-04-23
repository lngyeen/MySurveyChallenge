//
//  SurveyDTO.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Foundation
import Japx

struct SurveyDTO: JapxCodable {
    let id: String
    let type: String
    let title: String?
    let description: String?
    let coverImageUrl: String?
    let surveyType: String?
    let createdAt: Date?
    let activeAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case title
        case description
        case coverImageUrl = "cover_image_url"
        case surveyType = "survey_type"
        case createdAt = "created_at"
        case activeAt = "active_at"
    }
}

extension SurveyDTO {
    static let samples = [SurveyDTO(id: "d5de6a8f8f5f1cfe51bc",
                                    type: "survey_simple",
                                    title: "Scarlett Bangkok",
                                    description: "We'd love to hear from you!",
                                    coverImageUrl: "https://ucarecdn.com/62886578-df8b-4f65-902e-8e88d97748b8/-/quality/smart_retina/-/format/auto/",
                                    surveyType: "Restaurant",
                                    createdAt: Date.now.addingTimeInterval(-4 * Date.oneHourTimeInterval),
                                    activeAt: Date.now),
                          SurveyDTO(id: "ed1d4f0ff19a56073a14",
                                    type: "survey_simple",
                                    title: "ibis Bangkok Riverside",
                                    description: "We'd love to hear from you!",
                                    coverImageUrl: "https://ucarecdn.com/e4bc340d-27e8-4698-80f2-91e0e5c91a13/-/quality/smart_retina/-/format/auto/",
                                    surveyType: "Restaurant",
                                    createdAt: Date.now.addingTimeInterval(-1 * Date.oneDayTimeInterval),
                                    activeAt: Date.now),
                          SurveyDTO(id: "270130035d415c1d90bb",
                                    type: "survey_simple",
                                    title: "21 on Rajah",
                                    description: "We'd love to hear from you!",
                                    coverImageUrl: "https://ucarecdn.com/ed35738a-31e0-476c-8af3-1cf3dfb92ad9/-/quality/smart_retina/-/format/auto/",
                                    surveyType: "Restaurant",
                                    createdAt: Date.now.addingTimeInterval(-2 * Date.oneDayTimeInterval),
                                    activeAt: Date.now),
                          SurveyDTO(id: "a83d91f5518e5c14a8bf",
                                    type: "survey_simple",
                                    title: "Let's Chick",
                                    description: "We'd love ot hear from you!",
                                    coverImageUrl: "https://ucarecdn.com/456f46fe-637c-4ed1-9d6d-67f4fd0f2bde/-/quality/smart_retina/-/format/auto/",
                                    surveyType: "Restaurant",
                                    createdAt: Date.now.addingTimeInterval(-3 * Date.oneDayTimeInterval),
                                    activeAt: Date.now)]

    static let json =
        """
            {
                "data": [
                    {
                        "id": "d5de6a8f8f5f1cfe51bc",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "Scarlett Bangkok",
                            "description": "We'd love ot hear from you!",
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/62886578-df8b-4f65-902e-8e88d97748b8/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-23T07:48:12.991Z",
                            "active_at": "2015-10-08T07:04:00.000Z",
                            "inactive_at": null,
                            "survey_type": "Restaurant"
                        }
                    },
                    {
                        "id": "ed1d4f0ff19a56073a14",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "ibis Bangkok Riverside",
                            "description": "We'd love to hear from you!",
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/e4bc340d-27e8-4698-80f2-91e0e5c91a13/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-23T03:32:24.585Z",
                            "active_at": "2016-01-22T04:12:00.000Z",
                            "inactive_at": null,
                            "survey_type": "Hotel"
                        }
                    },
                    {
                        "id": "270130035d415c1d90bb",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "21 on Rajah",
                            "description": "We'd love to hear from you!",
                            "thank_email_above_threshold": null,
                            "thank_email_below_threshold": null,
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/ed35738a-31e0-476c-8af3-1cf3dfb92ad9/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-20T10:08:42.531Z",
                            "active_at": "2017-01-20T10:08:42.512Z",
                            "inactive_at": null,
                            "survey_type": "Restaurant"
                        }
                    },
                    {
                        "id": "a83d91f5518e5c14a8bf",
                        "type": "survey_simple",
                        "attributes": {
                            "title": "Let's Chick",
                            "description": "We'd love to hear from you!",
                            "is_active": true,
                            "cover_image_url": "https://ucarecdn.com/456f46fe-637c-4ed1-9d6d-67f4fd0f2bde/-/quality/smart_retina/-/format/auto/",
                            "created_at": "2017-01-19T06:03:42.220Z",
                            "active_at": "2016-12-15T02:39:00.000Z",
                            "inactive_at": null,
                            "survey_type": "Restaurant"
                        }
                    }
                ],
                "meta": {
                    "page": 1,
                    "pages": 5,
                    "page_size": 4,
                    "records": 20
                }
            }
        """
}
