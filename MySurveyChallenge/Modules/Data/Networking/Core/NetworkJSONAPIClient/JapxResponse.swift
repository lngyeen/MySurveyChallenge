//
//  JapxResponse.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation

struct JapxResponse<T: Codable>: Codable {
    let data: T
}
