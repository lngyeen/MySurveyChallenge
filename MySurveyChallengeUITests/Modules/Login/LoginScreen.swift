//
//  LoginScreen.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation
import XCTest

class LoginScreen {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var loginScreen: XCUIElement {
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).matching(identifier: "LoginScreen").element(boundBy: 0)
    }

    var emailField: XCUIElement {
        app.textFields["Email"]
    }

    var passwordField: XCUIElement {
        app.secureTextFields["Password"]
    }

    var loginButton: XCUIElement {
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "LoginScreen").element(boundBy: 1)
    }

    func userSeeLoginScreen() {
        XCTAssertTrue(loginScreen.waitForExistence(timeout: 1))
    }

    func userLogin(email: String = TestData.UserCredentials.userName,
                   password: String = TestData.UserCredentials.userPassword)
    {
        emailField.tap()
        emailField.typeText(email)

        passwordField.tap()
        passwordField.typeText(password)

        loginButton.tap()
    }
}
