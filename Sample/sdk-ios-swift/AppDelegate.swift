//
//  AppDelegate.swift
//  sdk-ios-swift
//
//  Created by Luke Ashley-Fenn on 29/01/2018.
//  Copyright © 2018 Luke Ashley-Fenn. All rights reserved.
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return YotiSDK.application(app, open: url, options: options)
    }

}
