//
//  KeychainFrameworkAdapter.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation
import KeychainAccess

// sourcery: AutoMockable
public protocol KeychainFrameworkAdapter {
    func set(_ string: String, key: String) throws

    func set(_ data: Data, key: String) throws

    func get(_ key: String) throws -> String?

    func getData(_ key: String) throws -> Data?

    func remove(_ key: String) throws
}

public class KeychainFrameworkAdapterImpl: KeychainFrameworkAdapter {
    enum Constanst {
        static let mainKeychainIdentifier = "Bundle.main.bundleIdentifier"
    }

    private let keychain = Keychain(service: Constanst.mainKeychainIdentifier)

    public func set(_ string: String, key: String) throws {
        try keychain.set(string, key: key)
    }

    public func set(_ data: Data, key: String) throws {
        try keychain.set(data, key: key)
    }

    public func get(_ key: String) throws -> String? {
        try keychain.get(key)
    }

    public func getData(_ key: String) throws -> Data? {
        try keychain.getData(key)
    }

    public func remove(_ key: String) throws {
        try keychain.remove(key)
    }
}
