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
// resides in the tests for the FrameworksTestingShell project since it needs
// to rely on the existence of an actual UIApplication and UIWindow structure.
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
        subject = FloatingUIAlertController(title: "Red Alert", message: "Whooop Whooop Whooop", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Beam me up, Scotty!", style: UIAlertActionStyle.cancel, handler: nil)
        subject.addAction(action)

        subject.alertWindow = mockWindow

        subject.show()

        XCTAssertEqual(mockWindow.recorder.getCallCountFor("makeKeyAndVisible"), 1)
        XCTAssertEqual(mockViewController.recorder.getCallCountFor("presentViewController"), 1)
        let callRecord = mockViewController.recorder.getCallRecordFor("presentViewController")
        XCTAssertEqual(callRecord?[0] as? FloatingUIAlertController, subject)
    }


    func test_show_PresentsWithAnimationFlagAndCompletionHandler() {
        var completed = false
        let completionClosure = { ()->Void in
            completed = true
        }

        subject = FloatingUIAlertController(title: "Red Alert", message: "Whooop Whooop Whooop", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Beam me up, Scotty!", style: UIAlertActionStyle.cancel, handler: nil)
        subject.addAction(action)

        subject.alertWindow = mockWindow

        subject.show(animated: true, completion: completionClosure)

        XCTAssertEqual(mockWindow.recorder.getCallCountFor("makeKeyAndVisible"), 1)
        XCTAssertEqual(mockViewController.recorder.getCallCountFor("presentViewController"), 1)
        let callRecord = mockViewController.recorder.getCallRecordFor("presentViewController")
        XCTAssertEqual(callRecord?[0] as? FloatingUIAlertController, subject)
        XCTAssertEqual(callRecord?[1] as? Bool, true)
        let closure = callRecord?[2] as? (()->Void)
        closure?()
        XCTAssertTrue(completed)
    }

    func test_viewDidDisappear_HidesTheFloatingAlertWindow() {
        subject = FloatingUIAlertController(title: "Red Alert", message: "Whooop Whooop Whooop", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Beam me up, Scotty!", style: UIAlertActionStyle.cancel, handler: nil)
        subject.addAction(action)

        subject.alertWindow = mockWindow
        mockWindow.isHidden = false

        subject.viewDidDisappear(false)

        XCTAssertTrue(mockWindow.isHidden)
    }

    class MockUIWindow: UIWindow {
        let recorder = FuncRecorder()

        override func makeKeyAndVisible() {
            recorder.recordCallFor("makeKeyAndVisible", params: [])
        }
    }

    class MockUIViewController: UIViewController {
        let recorder = FuncRecorder()

        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
            recorder.recordCallFor("presentViewController", params: [viewControllerToPresent, flag, completion])
        }
    }

}
