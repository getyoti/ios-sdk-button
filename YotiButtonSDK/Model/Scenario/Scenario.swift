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
    
    public typealias ClientCompletion = (_ baseURL: URL?, _ token: String?, _ url: URL?, _ error: Error?) -> Bool
    public typealias BackendCompletion = (_ response: Data?, _ error: Error?) -> Void
    
    @objc public private(set) var useCaseID: String
    @objc public private(set) var clientSDKID: String
    @objc public private(set) var scenarioID: String
    @objc public private(set) var clientCompletion: ClientCompletion
    @objc public internal(set) var qrCodeURL: URL?
    @objc public private(set) var backendCompletion: BackendCompletion
    @objc public private(set) var customCertificate: CustomCertificate?
    @objc public private(set) var callbackBackendURL: URL?
    
    @objc public var isValid: Bool {
        return !useCaseID.isEmpty &&
            !clientSDKID.isEmpty &&
            !scenarioID.isEmpty
    }
    
    init(useCaseID: String,
         clientSDKID: String,
         scenarioID: String,
         clientCompletion: @escaping ClientCompletion,
         backendCompletion: @escaping BackendCompletion,
         customCertificate: CustomCertificate?,
         callbackBackendURL: URL?) {
        
        self.useCaseID = useCaseID
        self.clientSDKID = clientSDKID
        self.scenarioID = scenarioID
        self.clientCompletion = clientCompletion
        self.backendCompletion = backendCompletion
        self.customCertificate = customCertificate
        self.callbackBackendURL = callbackBackendURL
    }
}
