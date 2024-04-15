//
//  Result+.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

extension Result where Failure == NetworkAPIError {
    func mapToAppNetworkError() -> Result<Success, AppNetworkError> {
        mapError { AppNetworkErrorMapper.appNetworkErrorFrom(networkAPIError: $0) }
    }
}
