//
//  Observer.swift
//  PDLTestBench
//
//  Created by Robert Huston on 6/4/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import Foundation

public class Observer {

    // Dictionary of call names, containing arrays of parameter lists
    // for each invocation of a call name
    var callHistoryDictionary: [ String : [ [Any?] ] ]

    public init() {
        callHistoryDictionary = [:]
    }

    public func recordCallFor(name: String, params: [Any?]) {
        if callHistoryDictionary.keys.contains(name) {
            callHistoryDictionary[name]!.append(params)
        } else {
            callHistoryDictionary[name] = [params]
        }
    }

    public func getCallCountFor(name: String) -> Int {
        return callHistoryDictionary[name]?.count ?? 0
    }

    public func getCallHistoryFor(name: String) -> [[Any?]]? {
        return callHistoryDictionary[name]
    }

    public func getCallRecordFor(name: String, forInvocation invocation: Int = 0) -> [Any?]? {
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
