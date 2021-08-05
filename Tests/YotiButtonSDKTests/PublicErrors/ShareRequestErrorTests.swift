//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import XCTest
@testable import YotiButtonSDK

final class ShareRequestErrorTests: XCTestCase {
    func testGivenStatusCodeInError_whenDescriptionIsCalled_thenDescriptionContainsStatusCode() {
        for index in 100...599 {
            let error = ShareRequestError.httpRequestError(index)
            XCTAssertTrue(error.localizedDescription.contains("\(index)"))
        }
    }

    func testGivenReasonInScenarioRetrievalError_whenDescriptionIsCalled_thenDescriptionContainsReason() {
        XCTAssertTrue(ShareRequestError.scenarioRetrievalError("Foo").localizedDescription.contains("Foo"))
    }

    func testGivenReasonInStartScenarioError_whenDescriptionIsCalled_thenDescriptionContainsReason() {
        XCTAssertTrue(ShareRequestError.startScenarioError("Foo").localizedDescription.contains("Foo"))
    }

    func testGivenReasonInGenericError_whenDescriptionIsCalled_thenDescriptionContainsReason() {
        XCTAssertTrue(ShareRequestError.generic("Foo").localizedDescription.contains("Foo"))
    }
}
