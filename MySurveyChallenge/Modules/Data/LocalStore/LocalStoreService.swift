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

final class LocalStoreServiceImpl: LocalStoreService {
    func saveDataToCache(_ data: Data, fileName: String) throws {
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(fileName)
            try data.write(to: fileURL)
        }
    }

    func loadDataFromCache(_ fileName: String) throws -> Data? {
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(fileName)
            let jsonData = try Data(contentsOf: fileURL)
            return jsonData
        }
        return nil
    }
}
