//
//  LocalStoreService.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/17/24.
//

import Foundation

// sourcery: AutoMockable
public protocol LocalStoreService {
    func saveDataToCache(_ data: Data, fileName: String) throws
    func loadDataFromCache(_ fileName: String) throws -> Data?
}
