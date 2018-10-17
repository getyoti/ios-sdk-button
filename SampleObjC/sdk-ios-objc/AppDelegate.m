//
//  AppDelegate.m
//  sdk-ios-objc
//
//  Created by Simon Hamadene on 16/10/2018.
//  Copyright © 2018 Yoti Limited. All rights reserved.
//

#import "AppDelegate.h"
#import <YotiButtonSDK/YotiButtonSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSError* error = nil;
    YTBScenarioBuilder *selfieAuthScenarioBuilder = [[YTBScenarioBuilder alloc] init];
    selfieAuthScenarioBuilder.useCaseID = @"yoti_btn_1";
    selfieAuthScenarioBuilder.clientSDKID = @"ac00adbd-d298-42c7-b596-07638762c618";
    selfieAuthScenarioBuilder.scenarioID = @"de20ed05-3c43-4e62-b212-331ade746ef8";
    selfieAuthScenarioBuilder.callbackBackendURL = [NSURL URLWithString:@"https://android-test-yoti.herokuapp.com/profile-json"];
    YTBScenario *selfieAuthScenario = [selfieAuthScenarioBuilder create:&error];
    [YotiSDK addScenario: selfieAuthScenario];
    
    error = nil;
    YTBScenarioBuilder *rememberMePhotoIDScenarioBuilder = [[YTBScenarioBuilder alloc] init];
    rememberMePhotoIDScenarioBuilder.useCaseID = @"yoti_btn_2";
    rememberMePhotoIDScenarioBuilder.clientSDKID = @"ac00adbd-d298-42c7-b596-07638762c618";
    rememberMePhotoIDScenarioBuilder.scenarioID = @"82cfc365-38f1-4657-a646-1d04791c8780";
    rememberMePhotoIDScenarioBuilder.callbackBackendURL = [NSURL URLWithString:@"https://android-test-yoti.herokuapp.com/profile-json"];
    YTBScenario *rememberMePhotoIDScenario = [rememberMePhotoIDScenarioBuilder create:&error];
    [YotiSDK addScenario: rememberMePhotoIDScenario];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
