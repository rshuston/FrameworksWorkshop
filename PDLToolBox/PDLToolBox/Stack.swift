//
//  Stack.swift
//  PDLToolBox
//
//  Created by Robert Huston on 6/5/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import Foundation

public class Stack {

    var stack: [Any?]

    public init() {
        stack = []
    }

    public init(fromList: [Any?]) {
        stack = fromList
    }

    public func size() -> Int {
        return stack.count
    }

    public func push(value: Any?) {
        stack.append(value)
    }

    public func pop() -> (value: Any?, success: Bool) {
        var value: Any? = nil
        var success = false
        if stack.count > 0 {
            value = stack.removeLast()
            success = true
        }
        return (value: value, success: success)
    }

    public func clear() {
        stack.removeAll()
    }
    
}
