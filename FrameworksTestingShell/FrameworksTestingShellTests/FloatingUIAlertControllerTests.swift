//
//  FloatingUIAlertControllerTests.swift
//  FrameworksTestingShell
//
//  Created by Robert Huston on 7/17/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//



//
// NOTE:
//
// The FloatingUIAlertController actually resides in the PDLUIToolBox frameworks
// project. However, we test FloatingUIAlertController.presentStandardAlert()
// function here because the testing needs to actually use a properly set up
// UIApplication and window hierarchy.
//



import XCTest
@testable import PDLUIToolBox

class FloatingUIAlertControllerTests: XCTestCase {

    func test_presentStandardAlert_AddsNewWindowToWindowHierarcy() {
        let countBefore = UIApplication.shared.windows.count
        FloatingUIAlertController.presentStandardAlert(title: "Alert", message: "Hi, there!")
        let countAfter = UIApplication.shared.windows.count
        XCTAssert(countAfter > countBefore)
    }

    func test_presentStandardAlert_NewWindowContainsPresentedFloatingUIAlertController() {
        let countBefore = UIApplication.shared.windows.count
        FloatingUIAlertController.presentStandardAlert(title: "Alert", message: "Hi, there!")
        let countAfter = UIApplication.shared.windows.count

        if countAfter > countBefore {
            let frontWindow = UIApplication.shared.windows.last
            let presentedViewController = frontWindow?.rootViewController?.presentedViewController
            XCTAssert(presentedViewController is FloatingUIAlertController)
        }
    }

    func test_presentStandardAlert_PresentedFloatingUIAlertControllerContainsReferenceToWindow() {
        let countBefore = UIApplication.shared.windows.count
        FloatingUIAlertController.presentStandardAlert(title: "Alert", message: "Hi, there!")
        let countAfter = UIApplication.shared.windows.count

        if countAfter > countBefore {
            let frontWindow = UIApplication.shared.windows.last
            let presentedViewController = frontWindow?.rootViewController?.presentedViewController
            if presentedViewController is FloatingUIAlertController {
                let floatingAlertController = presentedViewController as! FloatingUIAlertController
                XCTAssertEqual(floatingAlertController.alertWindow, frontWindow)
            }
        }
    }

    func test_presentStandardAlert_PresentedFloatingUIAlertControllerIsProperlyFormed() {
        let countBefore = UIApplication.shared.windows.count
        FloatingUIAlertController.presentStandardAlert(title: "Alert", message: "Hi, there!")
        let countAfter = UIApplication.shared.windows.count

        if countAfter > countBefore {
            let frontWindow = UIApplication.shared.windows.last
            let presentedViewController = frontWindow?.rootViewController?.presentedViewController
            if presentedViewController is FloatingUIAlertController {
                let floatingAlertController = presentedViewController as! FloatingUIAlertController
                XCTAssertEqual(floatingAlertController.title, "Alert")
                XCTAssertEqual(floatingAlertController.message, "Hi, there!")
                XCTAssertEqual(floatingAlertController.actions.count, 1)
                if floatingAlertController.actions.count == 1 {
                    let action = floatingAlertController.actions[0]
                    XCTAssertEqual(action.title, "OK")
                }
            }
        }
    }
    
}
