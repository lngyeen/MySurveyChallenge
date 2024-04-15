//
//  DummyCodableModel.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

struct DummyCodableModel: Codable {
    let id: String
    let title: String
    let message: String

    static let json =
        """
        {
            "id": "10",
            "title": "title",
            "message": "message"
        }
        """
}
