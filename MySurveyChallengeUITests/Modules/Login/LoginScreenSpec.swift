//
//  LoginScreenSpec.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation
import XCTest

final class LoginScreenSpec: UISpec {
    var loginScreen: LoginScreen!
    var homeScreen: HomeScreen!
    var commonUIElements: CommonUIElements!

    override func setUpWithError() throws {
        try super.setUpWithError()

        loginScreen = LoginScreen(app: app)
        homeScreen = HomeScreen(app: app)
        commonUIElements = CommonUIElements(app: app)

        commonUIElements.logoutIfNeeded()
    }

    func testLogin() throws {
        loginScreen.userSeeLoginScreen()
        loginScreen.userLogin()
        homeScreen.userSeeHomeScreen()
    }
}
