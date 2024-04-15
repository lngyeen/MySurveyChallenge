//
//  KeychainStoreService.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

public final class KeychainStoreService: SecureStoreService {
    private let adapter: KeychainFrameworkAdapter
   
    init(adapter: KeychainFrameworkAdapter) {
        self.adapter = adapter
    }
   
    public func saveString(_ string: String, key: SecureStoreField) throws {
        do {
            try adapter.set(string, key: key.rawValue)
        }
        catch {
            throw SecureStoreError.saveFailed(error.localizedDescription)
        }
    }
   
    public func saveData(_ data: Data, key: SecureStoreField) throws {
        do {
            try adapter.set(data, key: key.rawValue)
        }
        catch {
            throw SecureStoreError.saveFailed(error.localizedDescription)
        }
    }
   
    public func getString(_ key: SecureStoreField) throws -> String? {
        do {
            return try adapter.get(key.rawValue)
        }
        catch {
            throw SecureStoreError.loadFailed(error.localizedDescription)
        }
    }
   
    public func getData(_ key: SecureStoreField) throws -> Data? {
        do {
            return try adapter.getData(key.rawValue)
        }
        catch {
            throw SecureStoreError.loadFailed(error.localizedDescription)
        }
    }
   
    public func remove(_ key: SecureStoreField) throws {
        do {
            try adapter.remove(key.rawValue)
        }
        catch {
            throw SecureStoreError.removeFailed(error.localizedDescription)
        }
    }
}
