//
//  SecureStoreService.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

public enum SecureStoreField: String {
    case credentials
}

public enum SecureStoreError: Error {
    case saveFailed(_ detail: String)
    case loadFailed(_ detail: String)
    case removeFailed(_ detail: String)
}

public protocol SecureStoreService {
    func saveString(_ string: String, key: SecureStoreField) throws

    func saveData(_ data: Data, key: SecureStoreField) throws

    func getString(_ key: SecureStoreField) throws -> String?

    func getData(_ key: SecureStoreField) throws -> Data?

    func remove(_ key: SecureStoreField) throws
}

public extension SecureStoreService {
    func saveObject<T: Codable>(_ object: T, key: SecureStoreField) throws {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(object)
            try saveData(encoded, key: key)
        } catch {
            throw SecureStoreError.saveFailed(error.localizedDescription)
        }
    }

    func getObject<T: Codable>(_ key: SecureStoreField) throws -> T? {
        if let data = try getData(key) {
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(T.self, from: data)
                return decoded
            } catch {
                throw SecureStoreError.loadFailed(error.localizedDescription)
            }
        }
        return nil
    }
}
