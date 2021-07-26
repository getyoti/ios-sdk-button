//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import XCTest
@testable import YotiButtonSDK

final class SetupErrorTests: XCTestCase {
    func testGivenURLInError_whenDescriptionIsCalled_thenDescriptionContainsError() {
        let error = SetupError.noIDAppInstalled(Theme.yoti.appStoreURL)
        XCTAssertTrue(error.localizedDescription.contains(Theme.yoti.appStoreURL.absoluteString))
    }

    func testGivenInvalidBundleURLSchemesError_whenDescriptionIsCalled_thenDescriptionContainsHint() {
        XCTAssertTrue(SetupError.invalidBundleURLSchemes.localizedDescription.contains("CFBundleURLSchemes"))
    }

    func testGivenInvalidApplicationQueriesSchemesError_whenDescriptionIsCalled_thenDescriptionContainsHint() {
        XCTAssertTrue(SetupError.invalidApplicationQueriesSchemes(nil).localizedDescription.contains("LSApplicationQueriesSchemes"))
        XCTAssertTrue(SetupError.invalidApplicationQueriesSchemes(Theme.yoti.appStoreURL).localizedDescription.contains("LSApplicationQueriesSchemes"))
    }
}
