//
//  UIView+ExtensionTests.swift
//  PDLUIToolBox
//
//  Created by Robert Huston on 7/30/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import XCTest
import PDLTestBench
@testable import PDLUIToolBox

class UIView_ExtensionTests: XCTestCase {

    var subject: UIView!

    override func setUp() {
        super.setUp()

        subject = UIView()
    }

    override func tearDown() {
        subject = nil

        super.tearDown()
    }

    func test_traverseViewHierarchy_InvokesClosureForViewWithNoSubviews() {
        var foundViews = [UIView]()

        subject.traverseViewHierarchy { (v: UIView) in
            foundViews.append(v)
        }

        XCTAssertEqual(foundViews.count, 1)
        if foundViews.count == 1 {
            XCTAssertEqual(foundViews[0], subject)
        }
    }

    func test_traverseViewHierarchy_InvokesClosureForEachViewInHierarchy() {
        let subview_1 = UIView()
        let subview_2 = UIView()
        let subview_3 = UIView()
        let subview_4 = UIView()
        let subview_5 = UIView()
        let subview_6 = UIView()
        var foundViews = [UIView]()

        subject.addSubview(subview_1)
        subject.addSubview(subview_2)

        subview_1.addSubview(subview_3)
        subview_1.addSubview(subview_4)

        subview_2.addSubview(subview_5)
        subview_2.addSubview(subview_6)

        subject.traverseViewHierarchy { (v: UIView) in
            foundViews.append(v)
        }

        XCTAssertEqual(foundViews.count, 7)
        if foundViews.count == 7 {
            XCTAssertEqual(foundViews[0], subject)

            XCTAssertEqual(foundViews[1], subview_1)
            XCTAssertEqual(foundViews[2], subview_3)
            XCTAssertEqual(foundViews[3], subview_4)

            XCTAssertEqual(foundViews[4], subview_2)
            XCTAssertEqual(foundViews[5], subview_5)
            XCTAssertEqual(foundViews[6], subview_6)
        }
    }

}
