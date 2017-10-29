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

    @IBAction func buttonWasTouchedUpInside(_ sender: UIButton) {
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
        let alertController = UIAlertController(title: "Normal Alert", message: "You've now been alerted.", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            self.label.text = "Foo"
        })
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: { () -> Void in
            self.label.text = "Bar"
        })
    }

    func showFloatingAlert() {
        FloatingUIAlertController.presentStandardAlert(title: "Floating Alert", message: "You've now been alerted.",
            action: { (UIAlertAction) -> Void in
                self.label.text = "Foo"
            },
            completion: { () -> Void in
                self.label.text = "Bar"
        })
    }

}

