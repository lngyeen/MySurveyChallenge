//
//  HomeScreen.swift
//  MySurveyChallengeUITests
//
//  Created by Nguyen Truong Luu on 4/23/24.
//

import Foundation
import XCTest

class HomeScreen {
    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var homeScreen: XCUIElement {
        surveyListQuery.element
    }

    func userSeeHomeScreen() {
        XCTAssertTrue(homeScreen.waitForExistence(timeout: 5))
    }

    func userSeePage(_ index: Int) {
        XCTAssertTrue(pageAt(index).waitForExistence(timeout: 5))
    }

    func userSwipeLeftPage(_ index: Int) {
        pageAt(index).swipeLeft()
    }

    private func pageAt(_ index: Int) -> XCUIElement {
        surveyListQuery.element(boundBy: index).children(matching: .image).element
    }

    private var surveyListQuery: XCUIElementQuery {
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching:
            .other).element.children(matching: .other).matching(identifier:
            "SurveyListView")
    }
}
