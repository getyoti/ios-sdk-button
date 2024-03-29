//
//  Copyright © 2018 Yoti Ltd. All rights reserved.
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
    selfieAuthScenarioBuilder.clientSDKID = @"fbc94ea7-7e55-4659-a5b7-ad1d3eb30aa0";
    selfieAuthScenarioBuilder.scenarioID = @"86f9d913-88b0-476c-92c5-f5e6bde57fbf";
    selfieAuthScenarioBuilder.callbackBackendURL = [NSURL URLWithString:@"https://android-test-yoti.herokuapp.com/profile-json"];
    YTBScenario *selfieAuthScenario = [selfieAuthScenarioBuilder create:&error];
    [YotiSDK addScenario: selfieAuthScenario];
    
    error = nil;
    YTBScenarioBuilder *rememberMePhotoIDScenarioBuilder = [[YTBScenarioBuilder alloc] init];
    rememberMePhotoIDScenarioBuilder.useCaseID = @"yoti_btn_2";
    rememberMePhotoIDScenarioBuilder.clientSDKID = @"fbc94ea7-7e55-4659-a5b7-ad1d3eb30aa0";
    rememberMePhotoIDScenarioBuilder.scenarioID = @"86f9d913-88b0-476c-92c5-f5e6bde57fbf";
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

-(BOOL) application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [YotiSDK application:application open:url options:options];
}

@end
