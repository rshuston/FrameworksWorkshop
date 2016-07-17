//
//  FloatingUIAlertControllerTests.swift
//  PDLUIToolBox
//
//  Created by Robert Huston on 7/17/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//


//
// NOTE:
//
// The testing of the FloatingUIAlertController.presentStandardAlert() function
// resides in the tests for the FrameworksTestingShell project since it needs to
// rely on the existence of an actual UIApplication and UIWindow structure.
//


import XCTest
import PDLTestBench
@testable import PDLUIToolBox

class FloatingUIAlertControllerTests: XCTestCase {

    var mockWindow: MockUIWindow!
    var mockViewController: MockUIViewController!
    var subject: FloatingUIAlertController!

    override func setUp() {
        super.setUp()

        mockWindow = MockUIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mockViewController = MockUIViewController()
        mockWindow.rootViewController = mockViewController
    }

    override func tearDown() {
        mockWindow = nil
        mockViewController = nil

        super.tearDown()
    }

    func test_show_PresentsFloatingAlertOnTheClassInstanceWindowRootViewController() {
        subject = FloatingUIAlertController(title: "Red Alert", message: "Whooop Whooop Whooop", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Beam me up, Scotty!", style: UIAlertActionStyle.Cancel, handler: nil)
        subject.addAction(action)

        subject.alertWindow = mockWindow

        subject.show()

        XCTAssertEqual(mockWindow.observer.getCallCountFor("makeKeyAndVisible"), 1)
        XCTAssertEqual(mockViewController.observer.getCallCountFor("presentViewController"), 1)
        let callRecord = mockViewController.observer.getCallRecordFor("presentViewController")
        XCTAssertEqual(callRecord?[0] as? FloatingUIAlertController, subject)
    }

    class MockUIWindow: UIWindow {
        let observer = Observer()

        override func makeKeyAndVisible() {
            observer.recordCallFor("makeKeyAndVisible", params: [])
        }
    }

    class MockUIViewController: UIViewController {
        let observer = Observer()

        override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
            observer.recordCallFor("presentViewController", params: [viewControllerToPresent, flag])
        }
    }

}
