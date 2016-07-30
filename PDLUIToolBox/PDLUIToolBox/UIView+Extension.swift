//
//  UIView+Extension.swift
//  PDLUIToolBox
//
//  Created by Robert Huston on 7/30/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import UIKit

public extension UIView {

    public func traverseViewHierarchy(found: (UIView) -> Void) {
        found(self)
        self.subviews.forEach { (v: UIView) in
            v.traverseViewHierarchy(found)
        }
    }
    
}