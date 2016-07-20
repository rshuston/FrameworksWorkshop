//
//  UIViewController+ExtensionTests.swift
//  FrameworksTestingShell
//
//  Created by Robert Huston on 7/19/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//


//
// NOTE:
//
// The UIViewController.frontViewController() extension to UIViewController
// actually resides in the PDLUIToolBox frameworks project. However, we need
// to test the function here because the tests need to actually use a properly
// set up UIApplication and window hierarchy.
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

    func test_frontViewController_HandlesEmptyViewControllerHierarchy() {
        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssertNil(frontViewController)
    }

    func test_frontViewController_FindsRootViewController() {
        let rootViewController = UIViewController()
        appWindow.rootViewController = rootViewController
        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === rootViewController)
    }

    func test_frontViewController_FindsRootViewControllerOfSubclass() {
        let rootViewController = TestUIViewController()
        appWindow.rootViewController = rootViewController
        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === rootViewController)
    }
    
    func test_frontViewController_FindsPresentedViewControllerOfSubclass() {
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

    func test_frontViewController_FindsSplitViewController() {
        let splitViewController = UISplitViewController()
        let masterViewController = UIViewController()
        let detailViewController = UIViewController()
        appWindow.rootViewController = splitViewController
        splitViewController.viewControllers = [masterViewController, detailViewController]

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === detailViewController)
    }

    func test_frontViewController_FindsSplitViewControllerOfSubclasses() {
        let splitViewController = TestUISplitViewController()
        let masterViewController = TestUIViewController()
        let detailViewController = TestUIViewController()
        appWindow.rootViewController = splitViewController
        splitViewController.viewControllers = [masterViewController, detailViewController]

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === detailViewController)
    }

    func test_frontViewController_FindsNavigationViewController() {
        let navigationViewController = UINavigationController()
        appWindow.rootViewController = navigationViewController
        let pushedViewController = UIViewController()
        navigationViewController.pushViewController(pushedViewController, animated: false)

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === pushedViewController)
    }

    func test_frontViewController_FindsNavigationViewControllerOfSubclass() {
        let navigationViewController = TestUINavigationController()
        appWindow.rootViewController = navigationViewController
        let pushedViewController = TestUIViewController()
        navigationViewController.pushViewController(pushedViewController, animated: false)

        appWindow.makeKeyWindow()

        let frontViewController = UIViewController.frontViewController()

        XCTAssert(frontViewController === pushedViewController)
    }

    func test_frontViewController_FindsTabBarViewController() {
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

    func test_frontViewController_FindsTabBarViewControllerOfSubclasses() {
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

    func test_frontViewController_FindsFrontViewControllerInCombinationHierarchy() {
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
