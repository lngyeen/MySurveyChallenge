//
//  PlatformUtils.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation

struct PlatformUtils {
    static var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    static var isUITesting: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-Testing")
    }
}
