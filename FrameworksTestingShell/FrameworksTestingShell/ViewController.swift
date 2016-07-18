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
        FloatingUIAlertController.presentStandardAlert(title: "Alert", message: "You've now been alerted.",
            action: { (UIAlertAction) -> Void in
                self.label.text = "Foo"
        },
            completion: { (Void) -> Void in
                self.label.text = "Bar"
        })
    }
    
}

