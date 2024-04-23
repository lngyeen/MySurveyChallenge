//
//  UISpec.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation
import XCTest

class UISpec: XCTestCase {
    private(set) var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["UI-Testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
}

extension UISpec {
    var logoutButton: XCUIElement {
        app.buttons["Log out"]
    }
}
