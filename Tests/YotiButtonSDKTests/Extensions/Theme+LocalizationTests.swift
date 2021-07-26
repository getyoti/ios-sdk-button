//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import XCTest
@testable import YotiButtonSDK

final class Theme_LocalizationTests: XCTestCase {
    func testGivenYotiTheme_whenStockCopyKeyCalled_thenYotiKeyIsReturned() {
        XCTAssertEqual(Theme.yoti.stockCopyKey.stringValue, "yoti.sdk.yoti.button.label")
    }

    func testGivenYotiUKTheme_whenStockCopyKeyCalled_thenYotiKeyIsReturned() {
        XCTAssertEqual(Theme.yotiUK.stockCopyKey.stringValue, "yoti.sdk.yoti.button.label")
    }

    func testGivenPartnershipTheme_whenStockCopyKeyCalled_thenPartnershipKeyIsReturned() {
        XCTAssertEqual(Theme.partnership.stockCopyKey.stringValue, "yoti.sdk.partnership.button.label")
    }

    func testGivenEasyIDTheme_whenStockCopyKeyCalled_thenEasyIDKeyIsReturned() {
        XCTAssertEqual(Theme.easyID.stockCopyKey.stringValue, "yoti.sdk.easyid.button.label")
    }

    func testGivenYotiTheme_whenStockCopyValueCalled_thenYotiValueIsReturned() {
        XCTAssertEqual(Theme.yoti.stockCopyValue, "CONTINUE WITH YOTI")
    }

    func testGivenYotiUKTheme_whenStockCopyValueCalled_thenYotiValueIsReturned() {
        XCTAssertEqual(Theme.yotiUK.stockCopyValue, "CONTINUE WITH YOTI")
    }

    func testGivenPartnershipTheme_whenStockCopyValueCalled_thenPartnershipValueIsReturned() {
        XCTAssertEqual(Theme.partnership.stockCopyValue, "Continue with your Digital ID")
    }

    func testGivenEasyIDTheme_whenStockCopyValueCalled_thenEasyIDValueIsReturned() {
        XCTAssertEqual(Theme.easyID.stockCopyValue, "Continue with Post Office EasyID")
    }
}
