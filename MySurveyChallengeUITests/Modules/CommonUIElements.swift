//
//  CommonUIElements.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation
import XCTest

class CommonUIElements {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var logoutButton: XCUIElement {
        app.buttons["Log out"]
    }

    func logoutIfNeeded() {
        if logoutButton.waitForExistence(timeout: 3) {
            logoutButton.tap()
        }
    }
}
