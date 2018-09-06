//
//  ScenarioBuilder.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

@objc(YTBScenarioBuilder)
public class ScenarioBuilder: NSObject {
    
    public var useCaseID: String?
    public var clientSDKID: String?
    public var scenarioID: String?
    public var qrCodeURL: URL?
    public var callbackBackendURL: URL?
    
    @objc public func setUseCaseID(_ useCaseID: String) -> Self {
        self.useCaseID = useCaseID
        return self
    }
    
    @objc public func setClientSDKID(_ clientSDKID: String) -> Self {
        self.clientSDKID = clientSDKID
        return self
    }
    
    @objc public func setScenarioID(_ scenarioID: String) -> Self {
        self.scenarioID = scenarioID
        return self
    }
    
    @objc public func setCallbackBackendURL(_ callbackBackendURL: URL) -> Self {
        self.callbackBackendURL = callbackBackendURL
        return self
    }
    
    
    @objc (create:)
    public func create() throws -> Scenario {
        
        guard let useCaseID = useCaseID else {
            throw GenericError.nilValue("useCaseID")
        }
        
        guard let clientSDKID = clientSDKID else {
            throw GenericError.nilValue("clientSDKID")
        }
        
        guard let scenarioID = scenarioID else {
            throw GenericError.nilValue("scenarioID")
        }


        let scenario = Scenario(useCaseID: useCaseID,
                                clientSDKID: clientSDKID,
                                scenarioID: scenarioID,
                                callbackBackendURL: callbackBackendURL)
        
        guard scenario.isValid else {
            throw ScenarioError.invalidScenario
        }
        
        return scenario
    }
    
}
