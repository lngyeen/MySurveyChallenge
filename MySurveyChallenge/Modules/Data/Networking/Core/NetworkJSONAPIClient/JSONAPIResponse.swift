//
//  JSONAPIResponse.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Foundation

struct JSONAPIResponse<T: Codable>: Codable {
    let data: T
    let meta: PagingInfo?
}
