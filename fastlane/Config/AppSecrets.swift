//
//  AppSecrets.swift
//  FastlaneRunner
//
//  Created by Nguyen Truong Luu on 4/17/24.
//  Copyright © 2024 Joshua Liebowitz. All rights reserved.
//

import Foundation

enum AppSecrets {
    static var appStoreConnectAPIKey: String { return "[[APPSTORE_CONNECT_API_KEY]]" }
    static var appStoreAPIKeyId: String { return "[[APPSTORE_API_KEY_ID]]" }
    static var appStoreIssuerId: String { return "[[APPSTORE_ISSUER_ID]]" }
}
