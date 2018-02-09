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
    var kernel = KernelSDK.shared
    private var scenarios = [String: Scenario]()
    
    // MARK: - Static Functions
    @objc(addScenario:)
    public static func add(scenario: Scenario) {
        shared.add(scenario: scenario)
    }
    
    @objc(getScenarioForUseCaseID:)
    public static func scenario(for useCaseID: String) -> Scenario? {
        return shared.scenario(for: useCaseID)
    }
    
    static func startScenario(for useCaseID: String) throws {
        try shared.startScenario(for: useCaseID)
    }
    
    // MARK: - Instance Functions
    func add(scenario: Scenario) {
        scenarios[scenario.useCaseID] = scenario
    }
    
    func scenario(for useCaseID: String) -> Scenario? {
        return scenarios[useCaseID]
    }
    
    func startScenario(for useCaseID: String) throws {
        
        guard let scenario = scenario(for: useCaseID) else {
            throw GenericError.nilValue("scenario")
        }
        
        guard scenario.isValid else {
            throw ScenarioError.invalidScenario
        }
        
        kernel.startScenario(for: useCaseID)
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
        
        if !scenario.clientCompletion(callbackComponents?.url?.baseURL, token, callbackComponents?.url, nil) {
            kernel.callbackBackend(scenario: scenario, token: token)
        }
        
        return true
    }
}
