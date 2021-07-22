# ChangeLog

## Version 4.0.0

A `Theme` type is included that changes the look and feel of the button.

### Migration Guide
It is recommended to select a theme to have the most control over the appearance and behaviour of the button.
If you opt to use the partnership theme (the default for UK users), it is recommended the button be placed beneath any other buttons in your layout.
A height of 72pt should be used for the partnership theme and at least 44pt for the other themes.
In addition to this, at least 300pt width should accommodate the default English language text.

For localisation include a `.strings` file named `YotiButtonSDK` in your application bundle and specify the following keys based on the theme:

"yoti.sdk.yoti.button.label"
"yoti.sdk.easyid.button.label"
"yoti.sdk.partnership.button.label"
"yoti.sdk.support_info.text" (partnership theme)

You can alternativly continue to call `func setTitle(_ title: String?, for state: UIControl.State)` after `viewDidAppear`.

Update your app's `Info.plist` to include `easyid` in the `LSApplicationQueriesSchemes`.

Lastly, update the `yotiSDKDidFail` delegate callback to include the optional `appStoreURL` parameter, which you can use to redirect users to download Yoti or EasyID.
