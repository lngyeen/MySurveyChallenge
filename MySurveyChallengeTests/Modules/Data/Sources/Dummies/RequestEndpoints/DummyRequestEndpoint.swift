//
//  DummyRequestEndpoint.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Alamofire
import Foundation

@testable import MySurveyChallenge

enum DummyRequestEndpoint: RequestEndpoint {
    case test

    var baseURL: String { "https://example.com" }

    var path: String { "/api" }

    var method: Alamofire.HTTPMethod { .get }

    var sampleData: Data {
        DummyJSONAPIDTO.json.data
    }
}
