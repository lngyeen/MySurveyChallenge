//
//  PagingInfo.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Foundation

struct PagingInfo: Codable {
    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int

    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case pageSize = "page_size"
        case records
    }
}

extension PagingInfo {
    func toNetworkPadingInfo() -> NetworkPagingInfo {
        return NetworkPagingInfo(page: page, pages: pages, pageSize: pageSize, records: records)
    }
}

extension PagingInfo {
    static let sample = PagingInfo(page: 1, pages: 10, pageSize: 2, records: 20)
}
