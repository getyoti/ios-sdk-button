# ios-sdk-button

The mobile SDK purpose is to provide 3rd party applications the ability to request attributes from a Yoti user while leveraging the Yoti mobile App. It is an interaction between a 3rd Party app and Yoti app facilitated by a very lightweight SDKs.
This repo contains the tools and step by step instructions so that your users can share their identity details with your application in a secure and trusted way. 

## Requirements
- You will need to have the Yoti app on your phone
- You will need to ensure the minimum version of the deployment target is 9.0 or above.

## Installing the SDK

There are three sections to complete installing the mobile SDK:

1. First please follow our Yoti dashboard process. You will need to create an organisation [here](https://www.yoti.com/dashboard/login-organisations). After organisation creation you will need to create a Yoti application. If you are testing or using yoti for personal use please go straight to creating an application [here](https://www.yoti.com/dashboard/login).

    The application process will generate keys for you. Please keep your sdk id and scenario id safe for the mobile integration.

    For more information please follow our developer page instructions located [here](https://www.yoti.com/developers/).
2. Installing the web SDK. Please browse through our github page and initialise the web sdk in your web backend. 

    For more information please follow our developer page instructions located [here](https://www.yoti.com/developers/ ).
3.  Installing the Mobile SDK. This can be done using one of the three methods below:
    - Carthage - desired preference
    - Drag and drop 
    - Pod - coming soon.

### Carthage (recommended)

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```
$ brew update
$ brew install carthage
```

To integrate Yoti into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "getyoti/ios-sdk-button" ~> 1.0
```

This will allow you to type `carthage update ios-sdk-button` in your Terminal to fetch and build the latest version of the framework.
The first time you are integrating the iOS SDK,  the dynamic framework will be generated at `Carthage/Build/iOS/`. 

Drag the built `YotiButtonSDK.framework` into your Xcode project without copying it. Don't commit the `Carthage` folder but do commit the `Carthage.resolved` file.

Each time you want to fetch the dependency, you can type  `carthage bootstrap`.

### Drag & Drop (not recommended)

You can also add the Yoti SDK by adding the project via a submodule and dragging the Yoti's project file into yours.

### Pod

We don't currently support Pod but it's coming soon.

## Configuration
Before we start the configuration you have to add Yoti SDK as a build phase:
Go to your project, and go to the `Build Phases` tab, press the `+` on the top left, select `New Copy Files Phase` and change the `Destination` to `Frameworks`.

Click the `+` on the new Phase and select YotiButtonSDK.framework and click `add`.

Navigate to where you want to integrate the Yoti button, add a button and change class to YotiButton. 

**Class**: YotiButton

**Module**: YotiButtonSDK

Add a **User defined runtime attributes**: `useCaseID` of type String with a value which will allow you to identify the button.

### Yoti Button 

The SDK provide a custom Button you can use in your layout, do not forget to set the `useCaseID`, it's the link with the `Scenario`. See definitions lower. Or you can also define the button in the code like this:

Swift:
```swift

import YotiButtonSDK

let button = YotiButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
button.useCaseID = "YOUR_USE_CASE_ID"
```
Objective-C:
```objective-C

#import <YotiButtonSDK/YotiButtonSDK.h>                                                                                                                                                                                                                 YotiButton* button = [[YotiButton alloc] initWithFrame:CGRectMake(0, 0, 230, 48)]
button.useCaseID = "YOUR_USE_CASE_ID"
```

The front end of the integration is now complete.


### Create a Scenario

You will now need your SDK ID, Scenario ID and call back URL ready from your application dashboard. 

The SDK will need to be initialised, please add like below, your scenarios. Note that the SDK can support now multiple scenarios:

Swift:
Please add the scenario method in your appDelegate.swift in :

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
Objective-C:
Please add the scenarion method in your appDelegate.m in

```objective-c


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
```

```objective-c

#import <YotiButtonSDK/YotiButtonSDK.h>


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

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
}
```
then in your viewController class inside your button IBAction function call the function  : 

```swift

public static func startScenario(for useCaseID: String, with delegate: YotiSDKDelegate) throws 
```
by passing it the useCaseID and self as delegate like this:

Swift:

```swift

@IBAction func yotiButtonDidTouchUpInside(_ sender: YotiButton) {
	guard let useCaseID = sender.useCaseID else{
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

Objective-C: 

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
    	//handle here the error opening of Yoti app
    }

    func yotiSDKDidSucceed(for useCaseID: String, baseURL: URL?, token: String?, url: URL?) {
        //Handle here the success of the opening of Yoti app for example by requesting a profile from the backend like below
        //Get the specific scenario by calling  
        let scenario = YotiSDK.scenario(for: useCaseID)
        //request the backend to get the profile linked to a specific scenario by passing the token returned and self as delegate for a call back
        YotiSDK.callbackBackend(scenario: scenario!, token: token!, with: self)
    }

    func yotiSDKDidOpenYotiApp() {
    //Handle specific behaviour if needed when the Yoti App didOpen

    }
}
```

In Objective-C, your viewController should comply to  YTBSDKDelegate and YTBBackendDelegate like this:

```objective-c

@interface ViewController () <YTBSDKDelegate, YTBBackendDelegate>
```

then implement the delegate functions of the protocol it complies to like this:

```objective-c

- (void)yotiSDKDidFailFor:(NSString * _Nonnull)useCaseID with:(NSError * _Nonnull)error {
  // handle failure here
}

- (void)yotiSDKDidSucceedFor:(NSString * _Nonnull)useCaseID baseURL:(NSURL * _Nullable)baseURL token:(NSString * _Nullable)token url:(NSURL * _Nullable)url {
	YTBScenario *scenario = [YotiSDK scenarioforUseCaseID:useCaseID];
	[YotiSDK callbackBackendScenario:scenario token:token withDelegate:self];
}

- (void)yotiSDKDidOpenYotiApp {
	//behaviour when SDK opens yoti app (if needed)
}
```
when the callback returns from the backend we get the data linked to the profile or the error in

Swift:

```swift

func backendDidFinish(with data: Data?, error: Error?)
```

Objective-C:

```objective-c
- (void)backendDidFinishWith:(NSData * _Nullable)data error:(NSError * _Nullable)error

```
Here is one possible implementation for when the callback from the backend happens:

Swift:

```swift

extension ViewController: BackendDelegate {
    func backendDidFinish(with data: Data?, error: Error?) {
        guard let data = data else {
        return
        }
        do {
            let decodedJson = try JSONDecoder().decode(ProfileDictionary.self, from: data)
            responseObject = decodedJson
            moveToProfile()
        }
        catch let error {
            print (error)
        }
    }
}
```


Objective-C:

```objective-c

- (void)backendDidFinishWith:(NSData * _Nullable)data error:(NSError * _Nullable)error {
	if (data != nil) {
		NSError *jsonError = nil;
		responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
		[self moveToProfile];
    }
}

```

### Notifications
In case you need to change your interface before we are doing a network request, you can subscribe to the `willMakeNetworkRequest` and `didFinishNetworkRequest` notification from the `YotiSDK` class

Swift: 
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

Objective-C: 
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

Yoti SDK would perform an app switch to Yoti app and back to your app to complete the sharing process, your application's `.plist` also need to handle this.

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

#### Add Yoti as a query scheme

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>yoti</string>
</array>
```

#### Notify your application lifecycle to Yoti SDK

Swift:
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
Objective-C:
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
