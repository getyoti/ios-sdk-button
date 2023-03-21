//
//  Copyright © 2018 Yoti Ltd. All rights reserved.
//

import UIKit
import YotiButtonSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            // callback url.
            guard let url = URL(string: "https://android-test-yoti.herokuapp.com/profile-json") else {
                return false
            }

            // Here we need to add as many scenarios as we want. each scenario is linked to a button in the Main.storyboard.
            let selfieAuthScenario = try ScenarioBuilder().setUseCaseID("yoti_btn_1")
                .setClientSDKID("fbc94ea7-7e55-4659-a5b7-ad1d3eb30aa0")
                .setScenarioID("86f9d913-88b0-476c-92c5-f5e6bde57fbf")
                .setCallbackBackendURL(url)
                .create()
            YotiSDK.add(scenario: selfieAuthScenario)

            let rememberMePhotoIDScenario = try ScenarioBuilder().setUseCaseID("yoti_btn_2")
                .setClientSDKID("fbc94ea7-7e55-4659-a5b7-ad1d3eb30aa0")
                .setScenarioID("86f9d913-88b0-476c-92c5-f5e6bde57fbf")
                .setCallbackBackendURL(url)
                .create()
            YotiSDK.add(scenario: rememberMePhotoIDScenario)

        } catch let error {
            print("\(error.localizedDescription)")
        }
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return YotiSDK.application(app, open: url, options: options)
    }
}
