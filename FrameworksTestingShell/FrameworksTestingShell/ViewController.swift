//
//  ViewController.swift
//  FrameworksTestingShell
//
//  Created by Robert Huston on 7/17/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import UIKit
import PDLUIToolBox

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Foo"
    }

    @IBAction func buttonWasTouchedUpInside(sender: UIButton) {
        switch sender.currentTitle {
        case "Show Normal Alert"?:
            showNormalAlert()
        case "Show Floating Alert"?:
            showFloatingAlert()
        default:
            break
        }
    }

    func showNormalAlert() {
        let alertController = UIAlertController(title: "Normal Alert", message: "You've now been alerted.", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            self.label.text = "Foo"
        })
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: { (Void) -> Void in
            self.label.text = "Bar"
        })
    }

    func showFloatingAlert() {
        FloatingUIAlertController.presentStandardAlert(title: "Floating Alert", message: "You've now been alerted.",
            action: { (UIAlertAction) -> Void in
                self.label.text = "Foo"
            },
            completion: { (Void) -> Void in
                self.label.text = "Bar"
        })
    }

}

