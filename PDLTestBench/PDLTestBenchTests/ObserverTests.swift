//
//  ObserverTests.swift
//  PDLTestBench
//
//  Created by Robert Huston on 6/4/16.
//  Copyright © 2016 Pinpoint Dynamics. All rights reserved.
//

import XCTest
@testable import PDLTestBench

class ObserverTests: XCTestCase {

    var subject: Observer!

    override func setUp() {
        super.setUp()

        subject = Observer()
    }
    
    override func tearDown() {
        subject = nil

        super.tearDown()
    }

    func test_recordCallFor_recordsFirstCall() {
        subject.callHistoryDictionary = [:]

        subject.recordCallFor("foo", params: [1, "two"])

        XCTAssertEqual(1, subject.callHistoryDictionary.count)
        let callRecords = subject.callHistoryDictionary["foo"]
        XCTAssertEqual(1, callRecords?.count)
        let params = callRecords?[0]
        XCTAssertEqual(2, params?.count)
        XCTAssertEqual(1, params?[0] as? Int)
        XCTAssertEqual("two", params?[1] as? String)
    }

    func test_recordCallFor_recordsSubsequentCalls() {
        subject.callHistoryDictionary = [:]

        subject.recordCallFor("foo", params: [1, "two"])
        subject.recordCallFor("foo", params: [3, "four", 5.0])

        XCTAssertEqual(1, subject.callHistoryDictionary.count)
        let callRecords = subject.callHistoryDictionary["foo"]
        XCTAssertEqual(2, callRecords?.count)
        let params0 = callRecords?[0]
        XCTAssertEqual(2, params0?.count)
        XCTAssertEqual(1, params0?[0] as? Int)
        XCTAssertEqual("two", params0?[1] as? String)
        let params1 = callRecords?[1]
        XCTAssertEqual(3, params1?.count)
        XCTAssertEqual(3, params1?[0] as? Int)
        XCTAssertEqual("four", params1?[1] as? String)
        XCTAssertEqual(5.0, params1?[2] as? Double)
    }

    func test_getCallCountFor_returnsCorrectNumberForFirstCall() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3]]]

        let count = subject.getCallCountFor("foo")

        XCTAssertEqual(1, count)
    }

    func test_getCallCountFor_returnsCorrectNumberForSubsequentCalls() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let count = subject.getCallCountFor("foo")

        XCTAssertEqual(2, count)
    }

    func test_getCallCountFor_returnsZeroForUnrecordedCalls() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let count = subject.getCallCountFor("fubar")

        XCTAssertEqual(0, count)
    }

    func test_getCallHistoryFor_returnsCallHistoryForRegisteredCalls() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let callHistory = subject.getCallHistoryFor("foo")

        XCTAssertEqual(2, callHistory?.count)
        let record0 = callHistory?[0]
        XCTAssertEqual(3, record0?.count)
        XCTAssertEqual(1, record0?[0] as? Int)
        XCTAssertEqual(2, record0?[1] as? Int)
        XCTAssertEqual(3, record0?[2] as? Int)
        let record1 = callHistory?[1]
        XCTAssertEqual(3, record1?.count)
        XCTAssertEqual(4, record1?[0] as? Int)
        XCTAssertEqual(5, record1?[1] as? Int)
        XCTAssertEqual(6, record1?[2] as? Int)
    }

    func test_getCallHistoryFor_returnsNilForUnregisteredCalls() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let callHistory = subject.getCallHistoryFor("fubar")

        XCTAssertNil(callHistory)
    }

    func test_getCallRecordFor_returnsCorrectRecordForRegisteredCalls() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let record_0 = subject.getCallRecordFor("foo", forInvocation: 0)

        XCTAssertEqual(3, record_0?.count)
        XCTAssertEqual(1, record_0?[0] as? Int)
        XCTAssertEqual(2, record_0?[1] as? Int)
        XCTAssertEqual(3, record_0?[2] as? Int)

        let record_1 = subject.getCallRecordFor("foo", forInvocation: 1)

        XCTAssertEqual(3, record_1?.count)
        XCTAssertEqual(4, record_1?[0] as? Int)
        XCTAssertEqual(5, record_1?[1] as? Int)
        XCTAssertEqual(6, record_1?[2] as? Int)
    }

    func test_getCallRecordFor_returnsDefaultRecordOfFirstCall() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let record_0 = subject.getCallRecordFor("foo")

        XCTAssertEqual(3, record_0?.count)
        XCTAssertEqual(1, record_0?[0] as? Int)
        XCTAssertEqual(2, record_0?[1] as? Int)
        XCTAssertEqual(3, record_0?[2] as? Int)
    }

    func test_getCallRecordFor_returnsNilForInvalidInvocationNumber() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let record = subject.getCallRecordFor("foo", forInvocation: 2)

        XCTAssertNil(record)
    }

    func test_getCallRecordFor_returnsNilForUnregisteredCalls() {
        subject.callHistoryDictionary = ["foo": [[1, 2, 3],[4, 5, 6]]]

        let record = subject.getCallRecordFor("fubar", forInvocation: 1)

        XCTAssertNil(record)
    }

    func test_clearCallHistoryFor_clearsCallHistoryForRegisteredCalls() {
        subject.callHistoryDictionary = [
            "foo": [[1, 2, 3],[4, 5, 6]],
            "bar": [[1], [2], [3]]
        ]

        subject.clearCallHistoryFor("foo")

        XCTAssertEqual(1, subject.callHistoryDictionary.count)
        XCTAssertNil(subject.callHistoryDictionary["foo"])
        XCTAssertNotNil(subject.callHistoryDictionary["bar"])
    }

    func test_clearCallHistoryFor_doesNotClearCallHistoryForUnregisteredCalls() {
        subject.callHistoryDictionary = [
            "foo": [[1, 2, 3],[4, 5, 6]],
            "bar": [[1], [2], [3]]
        ]

        subject.clearCallHistoryFor("fubar")

        XCTAssertEqual(2, subject.callHistoryDictionary.count)
        XCTAssertNotNil(subject.callHistoryDictionary["foo"])
        XCTAssertNotNil(subject.callHistoryDictionary["bar"])
    }

    func test_clearAllCallHistories_() {
        subject.callHistoryDictionary = [
            "foo": [[1, 2, 3],[4, 5, 6]],
            "bar": [[1], [2], [3]]
        ]

        subject.clearAllCallHistories()

        XCTAssertEqual(0, subject.callHistoryDictionary.count)
    }

}
