//
//  FuncPlayer.swift
//  PDLTestBench
//
//  Created by Robert Huston on 6/4/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import Foundation
import PDLToolBox

public class FuncPlayer {

    class ValueSequencer {
        var segmentedSequenceList: SegmentedSequenceList
        var pendingInvocation: Int

        init() {
            segmentedSequenceList = SegmentedSequenceList()
            pendingInvocation = 1
        }

        init(segmentedSequenceList list:SegmentedSequenceList, pendingInvocation invocation: Int) {
            segmentedSequenceList = list
            pendingInvocation = invocation
        }
    }

    var returnValuesDictionary: [String : ValueSequencer]

    public init() {
        returnValuesDictionary = [:]
    }

    public func setReturnValue(value: Any?, forName name: String, forInvocation invocation: Int = 0) {
        let vs: ValueSequencer
        if returnValuesDictionary.keys.contains(name) {
            vs = returnValuesDictionary[name]!
        } else {
            vs = ValueSequencer()
            returnValuesDictionary[name] = vs
        }
        let index = invocation < 1 ? 1 : invocation
        vs.segmentedSequenceList.setValue(value, forIndex: index)
    }

    public func getReturnValueFor(name: String, forInvocation invocation: Int = 0) -> (value: Any?, success: Bool) {
        var result: (value: Any?, success: Bool) = (nil, false)
        if let vs = returnValuesDictionary[name] {
            let index = invocation < 1 ? vs.pendingInvocation : invocation
            let vs_result = vs.segmentedSequenceList.getValueFor(index)
            vs.pendingInvocation = index + 1
            result.value = vs_result.value
            result.success = vs_result.success
        }
        return result
    }

    public func clearReturnValuesFor(name: String) {
        returnValuesDictionary[name]?.segmentedSequenceList.clear()
        returnValuesDictionary[name]?.pendingInvocation = 1
    }

    public func clearAllReturnValues() {
        returnValuesDictionary.removeAll()
    }

    public func resetSequencerFor(name: String) {
        returnValuesDictionary[name]?.pendingInvocation = 1
    }
    
}
