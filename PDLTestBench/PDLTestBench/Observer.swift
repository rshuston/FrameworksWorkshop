//
//  Observer.swift
//  PDLTestBench
//
//  Created by Robert Huston on 6/4/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import Foundation

public class Observer {

    var callHistoryDictionary: [ String : [[AnyObject?]] ] = [:]

    public func recordCallFor(name: String, params: [AnyObject?]) {
        if callHistoryDictionary.keys.contains(name) {
            callHistoryDictionary[name]!.append(params)
        } else {
            callHistoryDictionary[name] = [params]
        }
    }

    public func getCallCountFor(name: String) -> Int {
        return callHistoryDictionary[name]?.count ?? 0
    }

    public func getCallHistoryFor(name: String) -> [[AnyObject?]]? {
        return callHistoryDictionary[name]
    }

    public func getCallRecordFor(name: String, forInvocation invocation: Int) -> [AnyObject?]? {
        guard let callHistory = callHistoryDictionary[name]
            where invocation < callHistory.count
            else {
                return nil
        }
        return callHistory[invocation]
    }

    public func clearCallHistoryFor(name: String) {
        if callHistoryDictionary.keys.contains(name) {
            callHistoryDictionary.removeValueForKey(name)
        }
    }

    public func clearAllCallHistories() {
        callHistoryDictionary.removeAll()
    }

}
