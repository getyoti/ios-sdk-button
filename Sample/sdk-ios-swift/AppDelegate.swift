//
//  Copyright © 2018 Yoti Ltd. All rights reserved.
//

import UIKit
import YotiButtonSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            //callback url.
            guard let url = URL(string: "https://android-test-yoti.herokuapp.com/profile-json") else {
                return false
            }

            //Here we need to add as many scenarios as we want. each scenario is linked to a button in the Main.storyboard.
            let selfieAuthScenario = try ScenarioBuilder().setUseCaseID("yoti_btn_1")
                .setClientSDKID("ac00adbd-d298-42c7-b596-07638762c618")
                .setScenarioID("de20ed05-3c43-4e62-b212-331ade746ef8")
                .setCallbackBackendURL(url)
                .create()
            YotiSDK.add(scenario: selfieAuthScenario)

            let rememberMePhotoIDScenario = try ScenarioBuilder().setUseCaseID("yoti_btn_2")
                .setClientSDKID("ac00adbd-d298-42c7-b596-07638762c618")
                .setScenarioID("82cfc365-38f1-4657-a646-1d04791c8780")
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
                     options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return YotiSDK.application(app, open: url, options: options)
    }
}
