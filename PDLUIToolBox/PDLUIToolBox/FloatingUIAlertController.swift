//
//  FloatingUIAlertController.swift
//  PDLUIToolBox
//
//  Created by Robert Huston on 7/17/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import UIKit

public class FloatingUIAlertController: UIAlertController {

    lazy var alertWindow: UIWindow = {
        let blankViewController = BlankViewController()
        blankViewController.view.backgroundColor = UIColor.clearColor()

        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = blankViewController
        window.backgroundColor = UIColor.clearColor()
        window.windowLevel = UIWindowLevelAlert

        return window
    }()


    override public func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        alertWindow.hidden = true
    }


    public func show(animated animated: Bool = false, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            rootViewController.presentViewController(self, animated: animated, completion: completion)
        }
    }


    class public func presentStandardAlert(title title: String, message: String, action: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alertController = FloatingUIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: action)
        alertController.addAction(alertAction)

        alertController.show(animated: true, completion: completion)
    }


    // For view controller-based status bar style, make sure we use the same style for ours
    private class BlankViewController: UIViewController {

        private override func prefersStatusBarHidden() -> Bool {
            return UIApplication.sharedApplication().statusBarHidden
        }

        private override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIApplication.sharedApplication().statusBarStyle
        }
        
    }
    
}
