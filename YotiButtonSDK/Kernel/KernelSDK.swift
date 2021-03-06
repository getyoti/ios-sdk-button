//
// Copyright © 2017 Yoti Limited. All rights reserved.
//

import Foundation
import Security
import UIKit

final class KernelSDK: NSObject {

    static let shared = KernelSDK()

    private lazy var retrieveScenarioService = RetrieveScenarioService()
    private lazy var callbackBackendService = CallbackBackendService()

    /**
     * Perform a call to the Yoti API to retrieve the scenario and start the Yoti App
     */
    func startScenario(for useCaseID: String, with delegate: SDKDelegate) {

        NotificationCenter.default.post(name: YotiSDK.willMakeNetworkRequest, object: nil)

        guard let querySchemes = Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String],
              querySchemes.contains("yoti") else {
            delegate.yotiSDKDidFail(for: useCaseID,
                                    with: SetupError.invalidApplicationQueriesSchemes(nil))
            return
        }

        guard let yotiAppUrl = URL(string: "yoti://send?text=Hello%2C%20World!"),
              UIApplication.shared.canOpenURL(yotiAppUrl) else {
            delegate.yotiSDKDidFail(for: useCaseID, with: SetupError.invalidApplicationQueriesSchemes(nil))
            return
        }

        guard let scenario = YotiSDK.shared.scenario(for: useCaseID) else { return }

        retrieve(scenario: scenario) { (qrCodeURL, error) in

            NotificationCenter.default.post(name: YotiSDK.didFinishNetworkRequest, object: nil)

            guard let qrCodeURL = qrCodeURL,
                  error == nil else {
                delegate.yotiSDKDidFail(for: useCaseID, with: error!)
                print("Error while retrieving the scenario from the Yoti API, please check your clientSDKID and scenarioID.")
                return
            }

            guard let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [Any],
                  let urlType = urlTypes.first as? [String: Any],
                  let sourceSchemes = urlType["CFBundleURLSchemes"] as? [String],
                  !sourceSchemes.isEmpty
            else {
                delegate.yotiSDKDidFail(for: useCaseID, with: SetupError.invalidBundleURLSchemes)
                print("CFBundleURLSchemes is undefined this app.")
                return
            }

            scenario.qrCodeURL = qrCodeURL

            var urlComponents = URLComponents(url: qrCodeURL, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = [URLQueryItem(name: "useCaseID", value: useCaseID),
                                         URLQueryItem(name: "sourceScheme", value: sourceSchemes.first)]

            guard let url = urlComponents?.url else {
                delegate.yotiSDKDidFail(for: useCaseID, with: ShareRequestError.startScenarioError("Malformed value received"))
                return
            }

            guard let applicationQuerySchemes = Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String],
                  applicationQuerySchemes.contains("yoti") else {
                delegate.yotiSDKDidFail(for: useCaseID, with: SetupError.invalidApplicationQueriesSchemes(url))
                return
            }

            UIApplication.shared.open(url, options: [:]) { isSuccessful in
                guard isSuccessful else {
                    let error: ShareRequestError = .startScenarioError("Yoti application could not be opened")
                    delegate.yotiSDKDidFail(for: useCaseID,
                                            with: error)
                    return
                }
                delegate.yotiSDKDidOpenYotiApp()
            }
        }
    }

    func retrieve(scenario: Scenario, completion: @escaping (_ qrCodeURL: URL?, _ error: Error?) -> Void) {
        retrieveScenarioService.retrieve(scenario: scenario) { (url, error) in
            DispatchQueue.main.async {
                completion(url, error)
            }
        }
    }

    public func callbackBackend(scenario: Scenario, token: String, with delegate: BackendDelegate) {
        callbackBackendService.callbackBackend(scenario: scenario, token: token) { (data, error) in
            delegate.backendDidFinish(with: data, error: error)
        }
    }
}
