//
//  NetworkPagingInfo.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Foundation

public struct NetworkPagingInfo {
    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int
}

extension NetworkPagingInfo {
    static let sample = NetworkPagingInfo(page: 1, pages: 10, pageSize: 2, records: 20)
}
