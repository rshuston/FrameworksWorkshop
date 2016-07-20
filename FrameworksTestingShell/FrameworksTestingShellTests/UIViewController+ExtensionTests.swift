//
//  UIViewController+ExtensionTests.swift
//  FrameworksTestingShell
//
//  Created by Robert Huston on 7/19/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import XCTest

class UIViewController_ExtensionTests: XCTestCase {

    let frameRect = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    var appWindow: UIWindow!

    override func setUp() {
        super.setUp()

        appWindow = UIWindow(frame: frameRect)
    }
    
    override func tearDown() {
        appWindow = nil

        super.tearDown()
    }

    func test_frontViewController_FindsRootView() {
        let rootViewController = UIViewController()
        appWindow.rootViewController = rootViewController
        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === rootViewController)
    }

    func test_frontViewController_FindsPresentedViewOfSubclass() {
        let rootViewController = UIViewController()
        let rootView = UIView(frame: frameRect)
        rootViewController.view = rootView
        appWindow.rootViewController = rootViewController
        appWindow.addSubview(rootView)
        appWindow.makeKeyWindow()

        let presentedController = TestUIViewController()
        rootViewController.presentViewController(presentedController, animated: false, completion: nil)

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === presentedController)
    }

    func test_frontViewController_FindsSplitView() {
        let splitViewController = UISplitViewController()
        let masterViewController = UIViewController()
        let detailViewController = UIViewController()
        appWindow.rootViewController = splitViewController
        splitViewController.viewControllers = [masterViewController, detailViewController]

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === detailViewController)
    }

    func test_frontViewController_FindsSplitViewOfSubclasses() {
        let splitViewController = TestUISplitViewController()
        let masterViewController = TestUIViewController()
        let detailViewController = TestUIViewController()
        appWindow.rootViewController = splitViewController
        splitViewController.viewControllers = [masterViewController, detailViewController]

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === detailViewController)
    }

    func test_frontViewController_FindsNavigationView() {
        let navigationViewController = UINavigationController()
        appWindow.rootViewController = navigationViewController
        let pushedViewController = UIViewController()
        navigationViewController.pushViewController(pushedViewController, animated: false)

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === pushedViewController)
    }

    func test_frontViewController_FindsNavigationViewOfSubclass() {
        let navigationViewController = TestUINavigationController()
        appWindow.rootViewController = navigationViewController
        let pushedViewController = TestUIViewController()
        navigationViewController.pushViewController(pushedViewController, animated: false)

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === pushedViewController)
    }

    func test_frontViewController_FindsTabBarView() {
        let tabBarViewController = UITabBarController()
        appWindow.rootViewController = tabBarViewController
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        tabBarViewController.viewControllers = [firstViewController, secondViewController]
        tabBarViewController.selectedIndex = 1
        
        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === secondViewController)
    }

    func test_frontViewController_FindsTabBarViewOfSubclasses() {
        let tabBarViewController = TestUITabBarController()
        appWindow.rootViewController = tabBarViewController
        let firstViewController = TestUIViewController()
        let secondViewController = TestUIViewController()
        tabBarViewController.viewControllers = [firstViewController, secondViewController]
        tabBarViewController.selectedIndex = 1

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === secondViewController)
    }

    func test_frontViewController_FindsViewInCombinationHierarchy() {
        let tabBarViewController = TestUITabBarController()
        appWindow.rootViewController = tabBarViewController
        let navigationViewController = TestUINavigationController()
        let viewController = TestUIViewController()
        tabBarViewController.viewControllers = [navigationViewController, viewController]
        tabBarViewController.selectedIndex = 0

        let pushedViewController = TestUIViewController()
        navigationViewController.pushViewController(pushedViewController, animated: false)

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === pushedViewController)
    }

    class TestUIViewController: UIViewController {
        let name = "TestUIViewController"
    }

    class TestUISplitViewController: UISplitViewController {
        let name = "TestUISplitViewController"
    }

    class TestUINavigationController: UINavigationController {
        let name = "TestUINavigationController"
    }

    class TestUITabBarController: UITabBarController {
        let name = "TestUITabBarController"
    }

}
