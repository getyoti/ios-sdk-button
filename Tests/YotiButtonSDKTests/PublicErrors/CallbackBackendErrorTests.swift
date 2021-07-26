//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import XCTest
@testable import YotiButtonSDK

final class CallbackBackendErrorTests: XCTestCase {
    func testGivenStatusCodeInError_whenDescriptionIsCalled_thenDescriptionContainsStatusCode() {
        for index in 100...599 {
            let error = CallbackBackendError.httpRequestError(index)
            XCTAssertTrue(error.localizedDescription.contains("\(index)"))
        }
    }

    func testGivenReasonInError_whenDescriptionIsCalled_thenDescriptionContainsReason() {
        XCTAssertTrue(CallbackBackendError.invalidCallbackBackendURL("Foo").localizedDescription.contains("Foo"))
    }
}
