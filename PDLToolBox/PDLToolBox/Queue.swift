//
//  Queue.swift
//  PDLToolBox
//
//  Created by Robert Huston on 6/12/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import Foundation

public class Queue {

    var queue: [Any?]

    public init() {
        queue = []
    }

    public init(fromList: [Any?]) {
        queue = fromList
    }

    public func size() -> Int {
        return queue.count
    }

    public func enqueue(value: Any?) {
        queue.append(value)
    }

    public func dequeue() -> (value: Any?, success: Bool) {
        var value: Any? = nil
        var success = false
        if queue.count > 0 {
            value = queue.removeFirst()
            success = true
        }
        return (value: value, success: success)
    }

    public func clear() {
        queue.removeAll()
    }

}
