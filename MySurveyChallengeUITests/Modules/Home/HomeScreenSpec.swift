//
//  HomeScreenSpec.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation
import XCTest

final class HomeScreenSpec: UISpec {
    var loginScreen: LoginScreen!
    var homeScreen: HomeScreen!
    var commonUIElements: CommonUIElements!

    override func setUpWithError() throws {
        try super.setUpWithError()

        loginScreen = LoginScreen(app: app)
        homeScreen = HomeScreen(app: app)
        commonUIElements = CommonUIElements(app: app)
    }

    func testSwipeToNextPage() throws {
        loginIfNeeded()
        homeScreen.userSeeHomeScreen()
        homeScreen.userSeePage(0)
        homeScreen.userSwipeLeftPage(0)
        homeScreen.userSeePage(1)
    }

    private func loginIfNeeded() {
        if !homeScreen.homeScreen.waitForExistence(timeout: 3) {
            loginScreen.userLogin()
        }
    }
}
