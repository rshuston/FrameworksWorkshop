//
//  FrameworksTestingShellUITests.swift
//  FrameworksTestingShellUITests
//
//  Created by Robert Huston on 7/17/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import XCTest

class FrameworksTestingShellUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil

        super.tearDown()
    }

    func testTappingButtonBringsUpAlert() {
        var label: XCUIElement
        var exists: NSPredicate

        XCTAssert(app.staticTexts["Foo"].exists)

        label = self.app.staticTexts["Bar"]
        exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: label, handler: nil)
        app.buttons["Button"].tap()
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssert(label.exists)

        label = self.app.staticTexts["Foo"]
        exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: label, handler: nil)
        app.alerts["Alert"].collectionViews.buttons["OK"].tap()
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssert(label.exists)
    }

}
