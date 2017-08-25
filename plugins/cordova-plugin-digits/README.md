# cordova-plugin-digits

This plugin provides native mobile Digits.com integration for both Android and iOS.

## Installation

This requires cordova 5.0+ (current stable 1.0.1)

    cordova plugin add cordova-plugin-digits --variable FABRIC_API_KEY=your_api_key --variable FABRIC_CONSUMER_KEY=your_consumer_key --variable FABRIC_CONSUMER_SECRET=your_consumer_secret

It is also possible to install via repo url directly (unstable)

    cordova plugin add https://github.com/JimmyMakesThings/cordova-plugin-digits --variable FABRIC_API_KEY=your_api_key --variable FABRIC_CONSUMER_KEY=your_consumer_key --variable FABRIC_CONSUMER_SECRET=your_consumer_secret

## Supported Platforms

 - iOS
 - Android

## Methods

 - window.plugins.digits.authenticate

### window.plugins.digits.authenticate

Initiates the Digits native interface. If successful the `authenticateSuccess` is called,
otherwise the `authenticateFailed` is called instead.

    window.plugins.digits.authenticate(options, authenticateSuccess, authenticateFailed);

#### Parameters

 - **options**: Theming options for iOS.
 - **authenticateSuccess**: The callback that is passed the authenticated info.
 - **geolocationError**: (Optional) The callback that executes if authentication fails.

#### Example

    // Currently only accentColor and backgroundColor is supported.
    // Note: These have no effect on Android.
    const options = {
      accentColor: '#ff0000',
      backgroundColor: '#ffffff',
    };

    window.plugins.digits.authenticate(options,
      (oAuthHeaders) => {
        console.log(oAuthHeaders);
      },
      (error) => {
        console.warn("[Digits]", "Login failed", error);
      }
    );

## Contributors

This plugin is based off the work of another plugin: [https://github.com/cosmith/cordova-digits](https://github.com/cosmith/cordova-digits).
