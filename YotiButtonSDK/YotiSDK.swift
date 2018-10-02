//
//  YotiSDK.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
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
    public static func startScenario(for useCaseID: String, with delegate: YotiSDKDelegate) throws {
        try shared.startScenario(for: useCaseID, with: delegate)
    }
    
    public static func callbackBackend(scenario: Scenario, token: String, with delegate: BackendDelegate) {
        shared.callbackBackend(scenario: scenario, token: token, with: delegate)
    }
    
    public static func scenario(for useCaseID: String) -> Scenario? {
        return shared.scenario(for:useCaseID)
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
    
    func startScenario(for useCaseID: String, with delegate: YotiSDKDelegate) throws {
        
        guard let scenario = scenario(for: useCaseID) else {
            throw GenericError.nilValue("scenario")
        }
        
        guard scenario.isValid else {
            throw ScenarioError.invalidScenario
        }
        
        scenario.currentDelegate = delegate
        
        kernel.startScenario(for: useCaseID, with: delegate)
    }
    
    // MARK: - UIApplication Delegate
    
    @objc public static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return shared.application(app, open: url, options: options)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let bundleID = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                  bundleID == EnvironmentConfiguation.YotiApp.bundleID
        else {
            return false
        }
        
        var callbackComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard let queryItems = callbackComponents?.queryItems, !queryItems.isEmpty else {
            return false
        }
        
        let useCaseIDValue = queryItems.first() { $0.name == "useCaseID" }?.value
        let tokenValue = queryItems.first() { $0.name == "token" }?.value
        
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
