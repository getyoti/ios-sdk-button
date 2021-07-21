//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

@objc
public class YotiSDK: NSObject {

    static let shared = YotiSDK()
    @objc public static let didFinishNetworkRequest = Notification.Name("com.yoti.didFinishNetworkRequest")
    @objc public static let willMakeNetworkRequest = Notification.Name("com.yoti.willMakeNetworkRequest")

    var kernel = KernelSDK.shared

    private var scenarios = [String: Scenario]()

    // MARK: - Static Functions
    @objc(addScenario:)
    public static func add(scenario: Scenario) {
        shared.add(scenario: scenario)
    }

    @objc(startScenarioForUseCaseID:withDelegate:error:)
    public static func startScenario(for useCaseID: String, with delegate: SDKDelegate) throws {
        try shared.startScenario(for: useCaseID, theme: Theme.default, with: delegate)
    }

    @objc(startScenarioForUseCaseID:theme:withDelegate:error:)
    public static func startScenario(for useCaseID: String, theme: Theme, with delegate: SDKDelegate) throws {
        try shared.startScenario(for: useCaseID, theme: theme, with: delegate)
    }

    @objc(callbackBackendScenario:token:withDelegate:)
    public static func callbackBackend(scenario: Scenario, token: String, with delegate: BackendDelegate) {
        shared.callbackBackend(scenario: scenario, token: token, with: delegate)
    }

    @objc(scenarioforUseCaseID:)
    public static func scenario(for useCaseID: String) -> Scenario? {
        return shared.scenario(for: useCaseID)
    }

    func callbackBackend(scenario: Scenario, token: String, with delegate: BackendDelegate) {
        kernel.callbackBackend(scenario: scenario, token: token, with: delegate)
    }

    // MARK: - Instance Functions
    func add(scenario: Scenario) {
        scenarios[scenario.useCaseID] = scenario
    }

    func scenario(for useCaseID: String) -> Scenario? {
        return scenarios[useCaseID]
    }

    func startScenario(for useCaseID: String, theme: Theme, with delegate: SDKDelegate) throws {
        guard let scenario = scenario(for: useCaseID) else {
            throw ShareRequestError.startScenarioError("No ScenarioID associated with this useCaseID")
        }

        guard scenario.isValid else {
            throw ShareRequestError.generic("Invalid value on UseCaseID, ClientSDKID, ScenarioID")
        }

        let expectedSchemes: Set<String>
        switch theme {
            case .easyID: expectedSchemes = ["easyid"]
            default: expectedSchemes = ["easyid", "yoti"]
        }

        guard let querySchemes = Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String],
              !expectedSchemes.isDisjoint(with: querySchemes) else {
            delegate.yotiSDKDidFail(for: useCaseID, appStoreURL: nil, with: SetupError.invalidApplicationQueriesSchemes(nil))
            return
        }

        let expectedURLs = expectedSchemes.compactMap{ URL(string:"\($0)://send?text=Hello%2C%20World!") }
        let canOpenURL = expectedURLs.contains{ UIApplication.shared.canOpenURL($0) }

        guard canOpenURL else {
            delegate.yotiSDKDidFail(for: useCaseID,
                                    appStoreURL: theme.appStoreURL,
                                    with: SetupError.noIDAppInstalled(theme.appStoreURL))
            return
        }

        scenario.currentDelegate = delegate
        kernel.startScenario(scenario, theme: theme, with: delegate)
    }

    // MARK: - UIApplication Delegate

    @objc public static func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return shared.application(app, open: url, options: options)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        if #available(iOS 13, *) { } else {
            guard let bundleID = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                      bundleID == EnvironmentConfiguration.YotiApp.bundleID
            else {
                return false
            }
        }

        var callbackComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        guard let queryItems = callbackComponents?.queryItems, !queryItems.isEmpty else {
            return false
        }

        let useCaseIDValue = queryItems.first { $0.name == "useCaseID" }?.value
        let tokenValue = queryItems.first { $0.name == "token" }?.value

        guard let useCaseID = useCaseIDValue, let token = tokenValue,
              let scenario = scenario(for: useCaseID)
        else {
            return false
        }

        callbackComponents?.scheme = "https"

        scenario.currentDelegate?.yotiSDKDidSucceed(for: useCaseID,
                                                    baseURL: callbackComponents?.url?.baseURL,
                                                    token: token,
                                                    url: callbackComponents?.url)
        return true
    }
}
