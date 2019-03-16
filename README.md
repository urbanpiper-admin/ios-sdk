
[![CocoaPods Compatible](http://img.shields.io/cocoapods/v/urbanpiper-swift.svg)](https://urbanpiper.com)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![Documentation](https://urbanpiper.github.io/urbanpiper/badge.svg)](https://urbanpiper.github.io/urbanpipersdk-ios)
# Table of Contents

<!-- MarkdownTOC -->

- [Introduction](#introduction)    
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
- [Initialization](#initialization)
- [User](#user)
- [User login](#user-login)
    - [Login](#login)
    - [Social user login](#social-login)
- [User registration](#user-registration)
    - [Registration](#registration)
    - [Social user registration](#social-registration)
- [Catalogue](#catalogue)
    - [Nearest store](#nearest-store)
    - [Store item categories](#store-item-catalogue)
    - [Category items](#category-items)
- [Cart](#cart)
    - [Add item](#add-item)
- [Ordering](#ordering)
    - [Place order](#place-order)

<!-- /MarkdownTOC -->

<a name="introduction"></a>
# Introduction

<a name="installation"></a>
# Installation

<a name="cocoapods"></a>
## CocoaPods

UrbanPiper supports `CocoaPods` for easy installation.
To Install, see our **[swift integration guide »](https://UrbanPiper.com/help/reference/swift)**

For iOS, tvOS, macOS, and App Extension integrations:

`pod 'UrbanPiper'`

<a name="carthage"></a>
## Carthage

UrbanPiper also supports `Carthage` to package your dependencies as a framework. Include the following dependency in your Cartfile:

`github "urbanpiper/ios-sdk"`

Check out the **[Carthage docs »](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)** for more info. 

<a name="initialization"></a>
# Initialization

Import UrbanPiper into AppDelegate.swift, and initialize UrbanPiper within `application:didFinishLaunchingWithOptions:`
![alt text]

```swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    UrbanPiper.intialize(language: APP_LANGUAGE, bizId: URBANPIPER_BIZID, apiUsername: URBANPIPER_API_USERNAME, 
                         apiKey: URBANPIPER_API_KEY, callback: CALLBACK)
    ...
}
```

You initialize the UrbanPiper instance with the params lanuguage, bizId, apiUsername, apiKey, callback

APP_LANGUAGE: Optional. Default - english. The `Language` the server should send the data.<br />
URBANPIPER_BIZID: your business id from urbanpiper.<br />
URBANPIPER_API_USERNAME: your api username from urbanpiper.<br />
URBANPIPER_API_KEY: your api key from urbanpiper.<br />
CALLBACK: callback notifies about the `SDKEvent` that should be handled by the app.<br />

<a name="user"></a>
## User

Once the SDK has been initialized the user object can be accessed from the SDK by calling the function below

```swift
   UrbanPiperSDK.sharedInstance().getUser()
```

<a name="user-login"></a>
## User login

<a name="login"></a>
<b>Login
    
An User can be logged in by calling the function below with the relevant params.

```swift
   UrbanPiper.sharedInstance().login(phone: PHONENUMBER, password: PASSWORD, 
                                     completion: COMPLETION_CALLBACK, failure: FAILURE_CALLBACK)
```

PHONENUMBER: The phone number passed in should be prefixed with the user's country code

<a name="social-login"></a>
<b>Social User Login
    
For a Social User Login the function below should be called with the relevant params

```swift
   UrbanPiper.sharedInstance().socialLogin(email: EMAIL, socialLoginProvider: PROVIDER, accessToken: PROVIDER_ACCESS_TtOKEN,         
                                           completion:COMPLETION_CALLBACK, failure: FAILURE_CALLBACK)
```

COMPLETION_CALLBACK: In the completion callback the `SocialLoginResponse` object is returned, the object contains the 'message' and 'success', if the success variable is 'true' then the social login was successfull, if the success variable is 'false' then the message variable provides you info on what it do next.

 if the message is 'phone_number_required' a new social user has to be registered, this can be done by following the steps mentioned in [Social User Registration](#social-registration)


PROVIDER: The currently supported providers are Google and Facebook<br />
PROVIDER_ACCESS_TOKEN: The token that is provided by the PROVIDER on successful login

<a name="user-registration"></a>
## User registration

<a name="registration"></a>
<b>Registration
    
Registering an user is a two step process, the user has to be registered using the registerUser api and then verify the account with the otp sent to the user's phone by calling the verifyRegOTP api

```swift
   // This returns an registration builder object that contains the relevant api call to register an user
   let registrationBuilder: RegistrationBuilder = UrbanPiper.sharedInstance().startRegistration()
   
   // Register an account with your business
   registrationBuilder.registerUser(phone: PHONENUMBER, name: USERNAME, email: EMAIL, password: PASSWORD, 
                                    completion: COMPLETION_CALLBACK, failure: @escaping FAILURE_CALLBACK)
   
   // Verify the account with the otp sent to the user's phone number
   // The phone number passed in should be prefixed with the user's country code
   registrationBuilder.registerUser(phone: PHONENUMBER, otp: OTP, email: EMAIL, password: PASSWORD, 
                                    completion: COMPLETION_CALLBACK, failure: @escaping FAILURE_CALLBACK)
```
OTP: 

<a name="social-registration"></a>
<b>Social User Registration
    
```swift
   Social user registration
```

<a name="catalogue"></a>
## Catalogue
```swift
   Nearest store
```
```swift
   Store categories
```
```swift
   Category items
```

<a name="cart"></a>
## Cart
```swift
   Add item
```

<a name="Ordering"></a>
## Ordering
```swift
   Place order
```
