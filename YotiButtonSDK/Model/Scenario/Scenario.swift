//
//  Scenario.swift
//  YotiButtonSDK
//
//  Created by Casper Lee on 20/07/2017.
//  Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation

@objc(YTBScenario)
public class Scenario: NSObject {

    @objc public private(set) var useCaseID: String
    @objc public private(set) var clientSDKID: String
    @objc public private(set) var scenarioID: String
    @objc public internal(set) var qrCodeURL: URL?
    @objc public private(set) var callbackBackendURL: URL?
    weak var currentDelegate: SDKDelegate?

    @objc public var isValid: Bool {
        return !useCaseID.isEmpty &&
            !clientSDKID.isEmpty &&
            !scenarioID.isEmpty
    }
    
    init(useCaseID: String,
         clientSDKID: String,
         scenarioID: String,
         callbackBackendURL: URL?) {
        
        self.useCaseID = useCaseID
        self.clientSDKID = clientSDKID
        self.scenarioID = scenarioID
        self.callbackBackendURL = callbackBackendURL
    }
}
