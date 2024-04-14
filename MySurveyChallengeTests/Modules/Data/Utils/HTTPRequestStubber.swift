//
//  HTTPStubs.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation
import OHHTTPStubs

@testable import MySurveyChallenge

enum HTTPRequestStubber {
    static func removeAllStubs() {
        HTTPStubs.removeAllStubs()
    }

    static func stub(
        _ request: RequestEndpoint,
        data: Data? = nil,
        statusCode: Int32 = 200
    ) {
        OHHTTPStubs.stub(condition: isPath(request.path)) { _ in
            HTTPStubsResponse(
                data: data ?? request.sampleData,
                statusCode: statusCode,
                headers: nil
            )
        }
    }

    static func stubError(
        _ request: RequestEndpoint,
        statusCode: Int32 = 400
    ) {
        OHHTTPStubs.stub(condition: isPath(request.path)) { _ in
            HTTPStubsResponse(error: "")
        }
    }
}
