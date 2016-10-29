//
//  FloatingUIAlertController.swift
//  PDLUIToolBox
//
//  Created by Robert Huston on 7/17/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import UIKit

open class FloatingUIAlertController: UIAlertController {

    lazy var alertWindow: UIWindow = {
        let blankViewController = BlankViewController()
        blankViewController.view.backgroundColor = UIColor.clear

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = blankViewController
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelAlert

        return window
    }()


    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        alertWindow.isHidden = true
    }


    open func show(animated: Bool = false, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            rootViewController.present(self, animated: animated, completion: completion)
        }
    }


    class open func presentStandardAlert(title: String, message: String, action: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alertController = FloatingUIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: action)
        alertController.addAction(alertAction)

        alertController.show(animated: true, completion: completion)
    }


    // For view controller-based status bar style, make sure we use the same style for ours
    fileprivate class BlankViewController: UIViewController {

        fileprivate override var prefersStatusBarHidden : Bool {
            return UIApplication.shared.isStatusBarHidden
        }

        fileprivate override var preferredStatusBarStyle : UIStatusBarStyle {
            return UIApplication.shared.statusBarStyle
        }
        
    }
    
}
