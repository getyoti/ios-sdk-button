[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](http://cocoapods.org/pods/yoti-sdk) 
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg?style=flat)](https://developer.apple.com/documentation)

# ios-sdk-button

The iOS Button SDK will provide your application the ability to request attributes from a Digital ID app* via a simple "sign in with" style button.
This repo contains the tools and step by step instructions so that your users can share their identity details with your application in a secure and trusted way. 

*Digital ID app is either the Yoti or EasyID iOS app*

## Requirements
- Digital ID application should be installed on the device
- The minimum version of the deployment target should be iOS 12.0 or above.
- You will need Xcode 12.0 or above
----

## Installing the SDK

There are three sections to complete installing the iOS Button SDK:

1. First please follow our Yoti dashboard process. You will need to create an organisation [here](https://www.yoti.com/dashboard/login-organisations). 
    After organisation creation you will need to create a Yoti application. If you are testing or using Yoti for personal use please go straight to creating an application [here](https://www.yoti.com/dashboard/login).

    The application process will generate keys for you. Please keep your sdk id and scenario id safe for the mobile integration.

    For more information please follow our developer page instructions located [here](https://www.yoti.com/developers/).
2. Installing the web sdk. Please browse through our github page and initialise the web sdk in your web backend. 

    For more information please follow our developer page instructions located [here](https://www.yoti.com/developers/ ).
3.  Installing the iOS Button SDK. This can be done using one of the methods below:
    - Swift Package Manager - (recommended)
    - Carthage
    - Cocoapods
    - Drag and drop 

### Swift Package Manager

[SPM](https://swift.org/package-manager/) is a decentralized dependency manager deeply integrated into Xcode and maintained by the Swift community project. 
This builds your dependencies and automatically links and embeds them in your application.

To integrate the iOS Button SDK into your Xcode project using SPM, simply add a new dependency in your Project's `Swift Packages`
Use the URL given by this repository's "Code" clone button.

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate iOS Button SDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "getyoti/ios-sdk-button" ~> 3.1.0
```

This will allow you to type `carthage update ios-sdk-button --use-xcframeworks` in your Terminal to fetch and build the latest version of the framework.
The first time you are integrating the iOS Button SDK,  the dynamic framework will be generated at `Carthage/Build/iOS/`. 

Drag the built `YotiButtonSDK.xcframework` into your Target's "Frameworks, Libraries, and Embedded Content". Don't commit the `Carthage` folder but do commit the `Carthage.resolved` file.

Each time you want to fetch the dependency, you can type  `carthage bootstrap --use-xcframeworks`.

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. Installation instructions are in [the guides](https://guides.cocoapods.org/using/getting-started.html#getting-started).


To integrate Yoti into your Xcode project using Cocoapods, specify it in your `Podfile`:

```
pod 'yoti-sdk', '~> 3.1.0'
```

Tip: CocoaPods provides a `pod init` command to create a Podfile with smart defaults. You should use it.

Now you can install the dependencies in your project:

```
$ pod install
```

Make sure to always open the Xcode workspace instead of the project file when building your project.

### Drag & Drop (not recommended)

You can also add iOS Button SDK by adding the project via a submodule and dragging the YotiButtonSDK project file into yours.

## Configuration

### Interface Builder

**Class**: YotiButton

**Module**: YotiButtonSDK

Navigate to where you want to integrate the button, add a UIView and change class to YotiButton.
Add layout constraints 
Add a **User defined runtime attributes**: `useCaseID` of type String with a value which will allow you to identify the button.
Link the button view with an appropriate IBOutlet.
Programatically assign a block/closure to the action property.
This action property returns the button instance to allow the same block/closure to be reused across multiple buttons.

### Programatically

You can simply instantiate the button providing a frame and assigning a `useCaseID` as shown in the following examples:

#### Swift:
```swift

import YotiButtonSDK

let button = YotiButton(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
button.useCaseID = "YOUR_USE_CASE_ID"
```
If you integrated using Cocoapods please use the following:

```swift

import yoti_sdk

let button = YotiButton(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
button.useCaseID = "YOUR_USE_CASE_ID"
```

#### Objective-C:
```objective-C

#import <YotiButtonSDK/YotiButtonSDK.h>                                                                                                           
YotiButton* button = [[YotiButton alloc] initWithFrame:CGRectMake(0, 0, 300, 44)]
button.useCaseID = "YOUR_USE_CASE_ID"
```

The UI integration is now complete.


### Create a Scenario

You will now need your SDK ID, Scenario ID and call back URL ready from your application dashboard. 

For each of the scenarios you want to handle, you would need to add them to the iOS Button SDK like below:

#### Swift:
Please add the scenario method in your AppDelegate.swift in :

```Objective-C

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
``` 

like below.


```swift

import YotiButtonSDK

    do {
        guard let url = URL(string: "YOUR_CALLBACK_URL") else {
            return false
        }
        //Here we need to add as many scenarios as we want. each scenario is linked to a button in the Main.storyboard.
        let firstScenario = try ScenarioBuilder().setUseCaseID("YOUR_FIRST_USE_CASE_ID")
        .setClientSDKID("YOUR_FIRST_CLIENT_SDK_ID")
        .setScenarioID("YOUR_FIRST_SCENARIO_ID_1")
        .setCallbackBackendURL(url)
        .create()
        YotiSDK.add(scenario: firstScenario)
                 
        let secondScenario = try ScenarioBuilder().setUseCaseID("YOUR_SECOND_USE_CASE_ID")
        .setClientSDKID("YOUR_SECOND_CLIENT_SDK_ID")
        .setScenarioID("YOUR_SECOND_SCENARIO_ID_2")
        .setCallbackBackendURL(url)
        .create()
        YotiSDK.add(scenario: secondScenario)
    } catch {
        // handle error code here
    }
}
```
#### Objective-C:
Please add the scenarion method in your appDelegate.m in

```objective-c


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
```

like below

```objective-c

#import <YotiButtonSDK/YotiButtonSDK.h>

    NSError* error = nil;
    YTBScenarioBuilder *firstScenarioBuilder = [[YTBScenarioBuilder alloc] init];
    firstScenarioBuilder.useCaseID = @"YOUR_FIRST_USE_CASE_ID";
    firstScenarioBuilder.clientSDKID = @"YOUR_FIRST_CLIENT_SDK_ID";
    firstScenarioBuilder.scenarioID = @"YOUR_FIRST_SCENARIO_ID";
    firstScenarioBuilder.callbackBackendURL = [NSURL URLWithString:@"YOUR_CALLBACK_URL"];
    YTBScenario *firstScenario = [firstScenarioBuilder create:&error];
    [YotiSDK addScenario: firstScenario];

    error = nil;
    YTBScenarioBuilder *secondScenarioBuilder = [[YTBScenarioBuilder alloc] init];
    secondScenarioBuilder.useCaseID = @"YOUR_SECOND_USE_CASE_ID";
    secondScenarioBuilder.clientSDKID = @"YOUR_SECOND_CLIENT_SDK_ID";
    secondScenarioBuilder.scenarioID = @"YOUR_SECOND_SCENARIO_ID";
    secondScenarioBuilder.callbackBackendURL = [NSURL URLWithString:@"YOUR_CALLBACK_URL"];
    YTBScenario *secondScenario = [secondScenarioBuilder create:&error];
    [YotiSDK addScenario: secondScenario];

    return YES;
```
then in your viewController class inside your button IBAction function call the function  : 

```swift

public static func startScenario(for useCaseID: String, with delegate: YotiSDKDelegate) throws 
```
Next, go to the view controller containing the YotiButton outlet. On its IBAction, call the sdk method signature in swift or signature in objective-c.

#### Swift:

```swift

@IBAction func yotiButtonDidTouchUpInside(_ sender: YotiButton) {
    guard let useCaseID = sender.useCaseID else {
        return
    }
    do {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        try YotiSDK.startScenario(for: useCaseID, with: self)
    } catch {
        // Handle error here
    }
}
```

#### Objective-C: 

```objective-c

- (IBAction)buttonDidTouchUpInside:(YotiButton*)sender {
    NSString* useCaseID = sender.useCaseID;
    NSError* error = nil;

    if (![useCaseID isEqual:@""]) {
        [YotiSDK startScenarioForUseCaseID:useCaseID withDelegate:self error:&error];

        if (error != nil) {
            NSLog(@"error : %@", error.description);
        }
    }
}
```

In Swift your ViewController class should comply to YotiSDKDelegate and to BackendDelegate in order to get the callbacks.

```swift

extension ViewController: YotiSDKDelegate {
    func yotiSDKDidFail(for useCaseID: String, with error: Error) {
    	// handle here the error related to the failing of retrieving a usecaseID and a token
    }

    func yotiSDKDidSucceed(for useCaseID: String, baseURL: URL?, token: String?, url: URL?) {
        // Handle here the success of the opening of Yoti app for example by requesting a profile from the backend like below
        // Get the specific scenario by calling  
        let scenario = YotiSDK.scenario(for: useCaseID)
        // request the backend to get the profile linked to a specific scenario by passing the token returned and self as delegate for a call back
        YotiSDK.callbackBackend(scenario: scenario!, token: token!, with: self)
    }

    func yotiSDKDidOpenYotiApp() {
        // Handle specific behaviour if needed when the Yoti App didOpen
    }
}
```

In Objective-C, your viewController should comply to  YTBSDKDelegate and YTBBackendDelegate like this:

```objective-c

@interface ViewController () <YTBSDKDelegate, YTBBackendDelegate>
```
BackendDelegate is its name in swift, YTBBackendDelegate namespace is for Objective-C
Note that complying to YTBBackendDelegate is optional because you might or not rely on a backend to implement your scenarios. Our current implementation relies on a backend to implement our scenarios.

We implemented the delegate functions of the protocols our ViewController complies to like this:

```objective-c

- (void)yotiSDKDidFailFor:(NSString * _Nonnull)useCaseID with:(NSError * _Nonnull)error {
    // handle failure here
}

- (void)yotiSDKDidSucceedFor:(NSString * _Nonnull)useCaseID baseURL:(NSURL * _Nullable)baseURL token:(NSString * _Nullable)token url:(NSURL * _Nullable)url {
	YTBScenario *scenario = [YotiSDK scenarioforUseCaseID:useCaseID];
	[YotiSDK callbackBackendScenario:scenario token:token withDelegate:self];
}

- (void)yotiSDKDidOpenYotiApp {
	// behaviour when SDK opens yoti app (if needed)
}
```
when the callback returns from the backend we get the data linked to the profile or the error in

#### Swift:

```swift

func backendDidFinish(with data: Data?, error: Error?)
```

#### Objective-C:

```objective-c
- (void)backendDidFinishWith:(NSData * _Nullable)data error:(NSError * _Nullable)error

```

### Notifications
In case you need to change your interface before we are doing a network request, you can subscribe to the `willMakeNetworkRequest` and `didFinishNetworkRequest` notification from the `YotiSDK` class

#### Swift: 
```swift
NotificationCenter.default.addObserver(forName: YotiSDK.willMakeNetworkRequest, object: nil, queue: nil) { (notification) in
    // Disable interface
}
```

```swift
NotificationCenter.default.addObserver(forName: YotiSDK.didFinishNetworkRequest, object: nil, queue: nil) { (notification) in
    // Re-enable interface
}
```

#### Objective-C: 
```objective-c
[NSNotificationCenter.defaultCenter addObserverForName:YotiSDK.willMakeNetworkRequest object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    // Disable interface
}];
```

```objective-c
[NSNotificationCenter.defaultCenter addObserverForName:YotiSDK.didFinishNetworkRequest object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    // Re-enable interface
}];
```

### Inter-app communication

iOS Button SDK will perform an app switch to the appropriate app and back to your app to complete the sharing process, your application's `.plist` also need to handle this.

#### Add your URL Scheme

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>YOUR_URL_SCHEME</string>
  </array>
  </dict>
</array>
```

#### Add Yoti and/or EasyID as a query scheme (both are recommended)

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>yoti</string>
    <string>easyid</string>
</array>
```

#### Notify iOS Button SDK of your application lifecycle

#### Swift:
```swift

import YotiButtonSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return YotiSDK.application(app, open:url, options:options)
    }
}
```
#### Objective-C:
```objective-c

#import <YotiButtonSDK/YotiButtonSDK.h>

@implementation AppDelegate
  - (BOOL)application:(UIApplication *)app
              openURL:(NSURL *)url
              options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
      return [YotiSDK application:app open:url options:options];
  }
@end
```

## Handling Users
The Web SDK will handle the user storage. When you retrieve the user profile, you receive a user ID generated by Yoti exclusively for your application. This means that if the same individual logs into another app, Yoti will assign her/him a different ID. You can use this ID to verify whether (for your application) the retrieved profile identifies a new or an existing user. Please see relevant github pages for more information.

## Support 
For any questions or support please email sdksupport@yoti.com. Please provide the following to get you up and working as quickly as possible:
- Software version on phone
- Language of Web SDK 
- Screenshot of error

Once we have answered your question we may contact you again to discuss Yoti products and services. If you’d prefer us not to do this, please let us know when you e-mail.
