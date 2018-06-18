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

```swift
import YotiButtonSDK

let button = YotiButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
button.useCaseID = "YOUR_USE_CASE_ID"
```

```Objective-C
#import <YotiButtonSDK/YotiButtonSDK.h>                                                                                                                                                                                                                 YotiButton* button = [[YotiButton alloc] initWithFrame:CGRectMake(0, 0, 230, 48)]
button.useCaseID = "YOUR_USE_CASE_ID"
```

The front end of the integration is now complete.


### Create a Scenario

You will now need to your SDK ID, Scenario ID and call back URL ready from your application dashboard. 

The SDK will need to be initialised, please and add the below scenario method:

Swift:
```swift
import YotiButtonSDK

do {
            let scenario = try ScenarioBuilder()
                .setUseCaseID("YOUR_USE_CASE_ID")
                .setClientSDKID("YOUR_CLIENT_SDK_ID")
                .setScenarioID("YOUR_SCENARIO_ID")
                .setClientCompletion({ (baseURL, token, url, error) in
                    // If you decide to call the callback url via
                    // your own Service and handle the result, set  isProcessed at true.
                    // Otherwise, set isProcessed at false and the Yoti SDK
                    // will make the call.
                    return false
                })
                .setCallbackBackendURL(URL(string:"YOUR_CALLBACK_URL")!)
                .create()
            
        } catch {
            // error management here
        }
```

Objective-C
```objective-c
#import <YotiButtonSDK/YotiButtonSDK.h>

NSError* error = nil;

YTBScenarioBuilder *myBuilder = [[YTBScenarioBuilder alloc] init];

myBuilder.useCaseID = @"YOUR_USE_CASE_ID";
myBuilder.clientSDKID = @"YOUR_CLIENT_SDK_ID";
myBuilder.scenarioID = @"YOUR_SCENARIO_ID";
myBuilder.callbackBackendURL = [NSURL URLWithString:@"YOUR_CALLBACK_URL"]
myBuilder.clientCompletion = (^BOOL(NSURL * _Nullable baseURL,
                                    NSString * _Nullable token,
                                    NSURL * _Nullable url,
                                    NSError * _Nullable error) {
  // If you decide to call the callback url via
  // your own Service and handle the result, set isProcessed at true.
  // Otherwise, set isProcessed at false and the Yoti SDK
  // will make the call.
  return isProcessed
});

YTBScenario *myScenario = [myBuilder create:&error];
```
And then you can add the scenario to Yoti SDK with

Swift:
```swift
YotiSDK.add(scenario: scenario)
```
Objective-C:
```objective-c
[YotiSDK addScenario:scenario];
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
```Objective-C
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
