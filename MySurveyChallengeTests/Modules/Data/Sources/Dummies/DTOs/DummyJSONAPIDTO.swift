//
//  DummyJSONAPIDTO.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation
import Japx

struct DummyJSONAPIDTO: JapxCodable {
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

extension DummyJSONAPIDTO {
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
                }
            ],
            "meta": {
                "page": 1,
                "pages": 10,
                "page_size": 2,
                "records": 20
            }
        }
        """
}
