//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import XCTest
@testable import YotiButtonSDK

final class Theme_URLTests: XCTestCase {
    func testGivenYotiTheme_whenSchemeCalled_thenHttpsSchemeIsMapped() {
        XCTAssertEqual(Theme.yoti.scheme, "https")
    }

    func testGivenYotiUKTheme_whenSchemeCalled_thenHttpsSchemeIsMapped() {
        XCTAssertEqual(Theme.yotiUK.scheme, "https")
    }

    func testGivenPartnershipTheme_whenSchemeCalled_thenHttpsSchemeIsMapped() {
        XCTAssertEqual(Theme.partnership.scheme, "https")
    }

    func testGivenEasyIDTheme_whenSchemeCalled_thenEasyIDSchemeIsMapped() {
        XCTAssertEqual(Theme.easyID.scheme, "easyid")
    }

    func testGivenYotiTheme_whenAppStoreURLCalled_thenYotiAppStoreURLIsReturned() {
        XCTAssertEqual(Theme.yoti.appStoreURL.absoluteString, "itms-apps://itunes.apple.com/app/id983980808")
    }

    func testGivenYotiUKTheme_whenAppStoreURLCalled_thenYotiAppStoreURLIsReturned() {
        XCTAssertEqual(Theme.yotiUK.appStoreURL.absoluteString, "itms-apps://itunes.apple.com/app/id983980808")
    }

    func testGivenPartnershipTheme_whenAppStoreURLCalled_thenYotiCodeURLIsReturned() {
        XCTAssertEqual(Theme.partnership.appStoreURL.absoluteString, "https://code.yoti.com")
    }

    func testGivenEasyIDTheme_whenAppStoreURLCalled_thenEasyIDAppStoreURLIsReturned() {
        XCTAssertEqual(Theme.easyID.appStoreURL.absoluteString, "itms-apps://itunes.apple.com/app/id1552010191")
    }
}
