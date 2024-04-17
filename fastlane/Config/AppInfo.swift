//
//  AppInfo.swift
//  FastlaneRunner
//
//  Created by Nguyen Truong Luu on 4/17/24.
//  Copyright © 2024 Joshua Liebowitz. All rights reserved.
//

import Foundation

enum AppInfo {
    static var appIdentifier: String { return "dev.luunguyen.MySurveyChallenge" }
    static var projectName: String { return "MySurveyChallenge" }
    static let projectPath: String = "./\(projectName).xcodeproj"
    static var workspace: String { return "./\(projectName).xcworkspace" }
    static var scheme: String { return projectName }

    static var appleId: String { return "[[APPLE_ID]]" } // Your Apple id (email)
    static var appleTeamId: String { return "[[TEAM_ID]]" } // Your Apple team id

    static var keychainName: String { return "fastlane" }
    static var keychainPassword: String { return "fastlane" }
    static var matchRepoUrl: String { return "[[MATCH_REPO_URL]]" } // Your match repo url

    static var testplan: String { return projectName }
    static var testDevices: [String] { return ["iPhone 15 Pro"] }
    static var testOutput: String { return "./fastlane/test_output" }
}
