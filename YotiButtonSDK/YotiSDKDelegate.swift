//
// Copyright © 2018 Yoti Limited. All rights reserved.
//

import Foundation

@objc(YTBScenarioRetrievalDelegate)
public protocol ScenarioRetrievalDelegate {
    func yotiSDKDidFail(`for` useCaseID: String, appStoreURL: URL?, with error: Error)
    func yotiSDKDidSucceed(`for` useCaseID: String, baseURL: URL?, token: String?, url: URL?)
}

@objc(YTBAppLaunchDelegate)
public protocol AppLaunchDelegate {
    func yotiSDKDidOpenYotiApp()
}

@objc(YTBSDKDelegate)
public protocol SDKDelegate: ScenarioRetrievalDelegate, AppLaunchDelegate {}
