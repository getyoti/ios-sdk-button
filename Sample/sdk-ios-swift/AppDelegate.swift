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
                .setClientSDKID("d10b19d3-fa50-48ab-bd8c-f5a099205e6c")
                .setScenarioID("17807359-a933-4b77-baa2-3c2fdb5608f2")
                .setCallbackBackendURL(url)
                .create()
            YotiSDK.add(scenario: selfieAuthScenario)

            let rememberMePhotoIDScenario = try ScenarioBuilder().setUseCaseID("yoti_btn_2")
                .setClientSDKID("d10b19d3-fa50-48ab-bd8c-f5a099205e6c")
                .setScenarioID("17807359-a933-4b77-baa2-3c2fdb5608f2")
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
