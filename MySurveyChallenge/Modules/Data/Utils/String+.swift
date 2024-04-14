//
//  String+.swift
//  MySurveyChallengeTests
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation

extension String: Error {}

extension String {
    var data: Data {
        return data(using: .utf8) ?? Data()
    }
}
