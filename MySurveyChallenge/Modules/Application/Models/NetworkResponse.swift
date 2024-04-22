//
//  NetworkResponse.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/22/24.
//

import Foundation

public struct NetworkResponse<T> {
    let data: T
    let meta: NetworkPagingInfo?
}
