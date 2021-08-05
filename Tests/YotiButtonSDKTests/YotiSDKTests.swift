//
// Copyright © 2021 Yoti Ltd. All rights reserved.
//

import XCTest
@testable import YotiButtonSDK

final class YotiSDKTests: XCTestCase {
    var mockDelegate: MockSDKDelegate!

    override func setUpWithError() throws {
        mockDelegate = .init()
    }

    override func tearDownWithError() throws {
        YotiSDK.shared.scenarios = [:]
    }

    func testGivenNoScenarioAdded_whenStartScenarioCalled_thenShareRequestErrorIsThrown() throws {
        XCTAssertThrowsError(try YotiSDK.startScenario(for: "Foo", with: mockDelegate))
        do {
            try YotiSDK.startScenario(for: "Foo", with: mockDelegate)
        } catch {
            XCTAssertTrue(error is ShareRequestError)
        }
    }

    func testGivenInvalidScenarioAdded_whenStartScenarioCalled_thenShareRequestErrorIsThrown() throws {
        YotiSDK.add(scenario: Scenario(useCaseID: "", clientSDKID: "", scenarioID: "", callbackBackendURL: nil))
        XCTAssertThrowsError(try YotiSDK.startScenario(for: "Foo", with: mockDelegate))
        do {
            try YotiSDK.startScenario(for: "Foo", with: mockDelegate)
        } catch {
            XCTAssertTrue(error is ShareRequestError)
        }
    }

    func testGivenNoScenarioAdded_whenStartScenarioWithThemeCalled_thenShareRequestErrorIsThrown() throws {
        XCTAssertThrowsError(try YotiSDK.startScenario(for: "Foo", with: mockDelegate))
        do {
            try YotiSDK.startScenario(for: "Foo", theme: .easyID, with: mockDelegate)
        } catch {
            XCTAssertTrue(error is ShareRequestError)
        }
    }

    func testGivenInvalidScenarioAdded_whenStartScenarioWithThemeCalled_thenShareRequestErrorIsThrown() throws {
        YotiSDK.add(scenario: Scenario(useCaseID: "", clientSDKID: "", scenarioID: "", callbackBackendURL: nil))
        XCTAssertThrowsError(try YotiSDK.startScenario(for: "Foo", with: mockDelegate))
        do {
            try YotiSDK.startScenario(for: "Foo", theme: .easyID, with: mockDelegate)
        } catch {
            XCTAssertTrue(error is ShareRequestError)
        }
    }

    func testGivenNoScenarioAdded_whenScenarioCalled_thenNoScenarioIsReturned() throws {
        XCTAssertNil(YotiSDK.scenario(for: "Foo"))
    }

    func testGivenScenarioAdded_whenScenarioCalled_thenScenarioIsReturned() throws {
        let scenario = Scenario(useCaseID: "Foo", clientSDKID: "Bar", scenarioID: UUID().uuidString, callbackBackendURL: nil)
        YotiSDK.add(scenario: scenario)
        XCTAssertEqual(YotiSDK.scenario(for: "Foo"), scenario)
    }

    func testGivenMultipleScenariosAdded_whenScenarioCalled_thenScenarioIsReturned() throws {
        for _ in 1...20 {
            let scenario = Scenario(useCaseID: UUID().uuidString,
                                    clientSDKID: UUID().uuidString,
                                    scenarioID: UUID().uuidString,
                                    callbackBackendURL: nil)
            YotiSDK.add(scenario: scenario)
        }
        let scenario = Scenario(useCaseID: "Foo", clientSDKID: "Bar", scenarioID: UUID().uuidString, callbackBackendURL: nil)
        YotiSDK.add(scenario: scenario)
        XCTAssertEqual(YotiSDK.scenario(for: "Foo"), scenario)
    }
}

extension YotiSDKTests {
    class MockSDKDelegate: SDKDelegate {
        var invokedYotiSDKDidFail = false
        var invokedYotiSDKDidFailCount = 0
        var invokedYotiSDKDidFailParameters: (useCaseID: String, appStoreURL: URL?, error: Error)?
        var invokedYotiSDKDidFailParametersList = [(useCaseID: String, appStoreURL: URL?, error: Error)]()
        func yotiSDKDidFail(`for` useCaseID: String, appStoreURL: URL?, with error: Error) {
            invokedYotiSDKDidFail = true
            invokedYotiSDKDidFailCount += 1
            invokedYotiSDKDidFailParameters = (useCaseID, appStoreURL, error)
            invokedYotiSDKDidFailParametersList.append((useCaseID, appStoreURL, error))
        }

        var invokedYotiSDKDidSucceed = false
        var invokedYotiSDKDidSucceedCount = 0
        var invokedYotiSDKDidSucceedParameters: (useCaseID: String, baseURL: URL?, token: String?, url: URL?)?
        var invokedYotiSDKDidSucceedParametersList = [(useCaseID: String, baseURL: URL?, token: String?, url: URL?)]()
        func yotiSDKDidSucceed(`for` useCaseID: String, baseURL: URL?, token: String?, url: URL?) {
            invokedYotiSDKDidSucceed = true
            invokedYotiSDKDidSucceedCount += 1
            invokedYotiSDKDidSucceedParameters = (useCaseID, baseURL, token, url)
            invokedYotiSDKDidSucceedParametersList.append((useCaseID, baseURL, token, url))
        }

        var invokedYotiSDKDidOpenYotiApp = false
        var invokedYotiSDKDidOpenYotiAppCount = 0

        func yotiSDKDidOpenYotiApp() {
            invokedYotiSDKDidOpenYotiApp = true
            invokedYotiSDKDidOpenYotiAppCount += 1
        }
    }
}
