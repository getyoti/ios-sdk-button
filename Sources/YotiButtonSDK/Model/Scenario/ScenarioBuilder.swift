//
// Copyright © 2017 Yoti Limited. All rights reserved.
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
            throw ShareRequestError.generic("Invalid UseCaseID")
        }

        guard let clientSDKID = clientSDKID else {
            throw ShareRequestError.generic("Invalid ClientSDKID")
        }

        guard let scenarioID = scenarioID else {
            throw ShareRequestError.generic("Invalid ScenarioID")
        }

        let scenario = Scenario(useCaseID: useCaseID,
                                clientSDKID: clientSDKID,
                                scenarioID: scenarioID,
                                callbackBackendURL: callbackBackendURL)

        guard scenario.isValid else {
            throw ShareRequestError.generic("Invalid value on UseCaseID, ClientSDKID, ScenarioID")
        }

        return scenario
    }

}
