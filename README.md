
[![CocoaPods Compatible](http://img.shields.io/cocoapods/v/urbanpiper-swift.svg)](https://urbanpiper.com)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)

# Table of Contents

<!-- MarkdownTOC -->

- [Introduction](#introduction)    
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
- [Initialization](#initialization)
- [Users & Authentication](#user-and-authentication)
    - [Login](#login)
    - [Social user login](#social-login)
- [User registration](#user-registration)
    - [Registration](#registration)
    - [Social user registration](#social-registration)
- [catalog](#catalog)
	- [nearest store](#get-nearest-store)
- [Item Option Builder](#item-option-builder)
- [Cart](#cart)
- [Ordering](#ordering)

<!-- /MarkdownTOC -->

<a name="introduction"></a>
# Introduction

UrbanPiper iOS SDK helps you build your iOS app by managing the communication between your iOS app and your business that is hosted by UrbanPiper.

The SDK supports all of the features that are supported by UrbanPiper order management system(OMS).

The following documentation contains the details on the essential methods that needs to be implemented to place an order from your iOS app.


<a name="how-sdk-works"></a>
# How UrbanPiper SDK works

The following are the steps that needs to be followed to place an order.

* [Initalizing the SDK](#initialization)
* [Logging in a user](#login)
* [Registering a new user](#registration)
* [How to get the catalog](#catalog)
* [Managing your cart](#cart)
* [Placing an order](#ordering)
 
The SDK is [initialized](#initialization) with the params `biz id`, `api username` and `api key` provided by UrbanPiper. if you don't have the keys you can contact urbanpiper at `support@urbanpiper.com` to get the keys for your business.

An User can login to your business by performing an [phone based login](#phone-based-login) or a [social user login](#social-login).

A new account can be registered in your business either by performing a [phone based registration](#phone-based-registration) or by a [social registration](social-registration).

To get the nearest store the user's location is required. with the user's location the [nearest store](#get-nearest-store) can be retrived from the server.

With the nearest store the store specific [categories](#get-categories) can be retrived from the server.

The [items](#get-category-items) for a specific store and category can be retrived from the server using the Store and Category details retrived previously.


The store specfic items can be added to the [cart](#add-to-cart).<br />
Note: to add an item with option groups the [ItemOptionBuilder](#item-option-builder) should be used to generate the cart item.

With items added to the cart the 

<a name="how-to-setup"></a>
# How to setup

The below guide provides you with the steps to install and initialize the SDK in your an iOS app.

<a name="installation"></a>
## Installation

The SDK supports installation via both CocoaPods and Carthage. Steps to integrate the SDK are shown below.

<a name="cocoapods"></a>
### CocoaPods

UrbanPiper supports `CocoaPods` for easy installation.
To Install, see our **[swift integration guide »](https://UrbanPiper.com/help/reference/swift)**

`pod 'UrbanPiper'`

<a name="carthage"></a>
### Carthage

UrbanPiper also supports `Carthage` to package your dependencies as a framework. Include the following dependency in your Cartfile:

`github "urbanpiper/ios-sdk"`

Check out the **[Carthage docs »](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)** for more info. 

<a name="initialization"></a>
## Initialization

Import UrbanPiper into AppDelegate.swift, and initialize UrbanPiper within `application:didFinishLaunchingWithOptions:`

```swift

import UrbanPiper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    	UrbanPiper.intialize(language: APP-LANGUAGE, bizId: URBANPIPER-BIZID, apiUsername: URBANPIPER-API-USERNAME, apiKey: URBANPIPER-API-KEY, callback: CALLBACK)
	}
}


```

| Params | Description |
|--------|-------------|
| APP-LANGUAGE | `Optional` `Default - english` The `Language` the server should send the data in. |
| URBANPIPER-BIZID | your business id from urbanpiper. |
| URBANPIPER-API-USERNAME | your api username from urbanpiper. |
| URBANPIPER-API-KEY | your api key from urbanpiper. |
| CALLBACK | callback notifies about the `SDKEvent` that should be handled by the app. |

You initialize the UrbanPiper instance with the params lanuguage, `bizId`, `apiUsername`, `apiKey`, `callback`. once initialized the sharedInstance of the SDK can be accessed by the class method `UrbanPiper.sharedInstance()`

To get your businesses credentials you can contact urbanpiper at `support@urbanpiper.com`.

<a name="user-and-authentication"></a>
# Users & Authentication

The following contains methods to related to the retriving user object, [logging in](#login) and [registering](#registration) an user.

<a name="login"></a>
## Login

A user can login into your business in two ways

* Phone based login.
* Social login.

Note: Once a user has successfully logged in the user object can be accessed by the SDK's [getUser()](#user) method

<a name="phone-based-login"></a>
### Phone based login

Logging an user into your business using phone number and password.

```swift

UrbanPiper.sharedInstance().login(phone: PHONE-NUMBER, password: PASSWORD, completion: COMPLETION-
										CALLBACK, failure: FAILURE-CALLBACK)
										
```

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| PASSWORD | Password entered by the user |


<a name="social-login"></a>
### Social login

The currently supported social login providers by the platform are `Google Sign In` and `Facebook Login` and have to be setup in your project before performing an social login with the SDK.

The setup for social login providers are out of scope of this document below are the links to guides for setting up the supported login providers.

* Google Sign in: **[Google sign in integration guide »](https://developers.google.com/identity/sign-in/ios/)**
* Facebook Login: **[Facebook login integration guide »](https://developers.facebook.com/docs/facebook-login/ios/)**

        
Once the social login flow of the selected provider is completed the user can be logged into your business by calling the following method.

```swift

UrbanPiper.sharedInstance().socialLogin(email: EMAIL, socialLoginProvider: PROVIDER, accessToken: PROVIDER-ACCESS-TOKEN, 
										completion:COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                           
```

| Params | Description |
|--------|-------------|
| EMAIL | The user's email id from the social login provider |
| PROVIDER | The social login method selected by the user (Google or Facebook) |
| PROVIDER-ACCESS-TOKEN | The access token returned by the social login provider (Google or Facebook) |

Note: the completion callback returns the `SocialLoginResponse` object with the variables `message` and `success`. 

* if the success variable is `true` then the social login was successfull.
* if the success variable is `false` and the message variable is `phone_number_required` the user has to registered to your business.

The [Social User Registration](#social-registration) section provides the steps to register an social login user.


<a name="registration"></a>
## Registration

An user can be registered to your business in two ways

* Phone based registration.
* Social Registration.

<a name="registration"></a>
### Phone Based Registration

For registration the Builder approach has been taken, to get an instance of the `RegistrationBuilder` the following method should be called on the `sharedInstance()` of the SDK.

```swift

// This returns an registration builder that contains the relevant methods to register an user
let registrationBuilder: RegistrationBuilder = UrbanPiper.sharedInstance().startRegistration()
   
```
    
User registration is a two step process.

* The user has to be registered using the `registerUser` method.
* verifiying the account with the otp sent to the user's phone number using the `verifyRegOTP` method.


Register an new user account with your business

```swift
   
registrationBuilder.registerUser(phone: PHONE-NUMBER, name: USERNAME, email: EMAIL, password: PASSWORD, 
                                    completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                    
```                                    

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| USERNAME | The name of the user |
| EMAIL | The email id provided by the user |
| PASSWORD | Password entered by the user |


Verify the account with the otp sent to the user's phone number in registerUser

```swift

registrationBuilder.verifyRegOTP(phone: PHONE-NUMBER, otp: OTP, email: EMAIL, password: PASSWORD, 
                                 completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                    
```

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| OTP | The otp sent to the phone number passed in the `registerUser` call |

Note: Once a user's `otp` has been verifed successfully the user has to logged into the sytem by using the [login](#login) method in the `sharedInstance()` of UrbanPiper SDK.

<a name="social-registration"></a>
### Social User Registration

The Social User Registration should only the initiated when the `success` varible in the [social login](#social-login) response is false and the `message` variable of the response is `phone_number_required`.

For Social User Registration the Builder approach has been taken, to get an instance of the `SocialRegBuilder` the following method should be called on the `sharedInstance()` of the SDK.

```swift

// This returns an social registration builder that contains the relevant methods to register an social login user
let socialRegBuilder: SocialRegBuilder = UrbanPiper.sharedInstance().startSocialRegistration()
   
```
Registering an social user starts with the method call to verify the phone number.

```swift

// Method to check if the passed in phone number is present in your business
socialRegBuilder.verifyPhone(name: USERNAME, phone: PHONE-NUMBER, email: EMAIL, gender: GENDER, provider: PROVIDER,
							 providerAccessToken: PROVIDER-ACCESS-TOKEN, completion: COMPLETION-CALLBACK, 
							 failure: FAILURE-CALLBACK)
                                 
```

| Params | Description |
|--------|-------------|
| USERNAME | The name of the user |
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| EMAIL | The user's email id from the social login provider |
| GENDER | `Optional` The user's gender from the social login provider |
| PROVIDER | The social login method selected by the user (Google or Facebook) |
| PROVIDER-ACCESS-TOKEN | The access token returned by the social login provider (Google or Facebook) |


The verifyPhone api returns an `RegistrationResponse` object with the variable `message`. Based on the value of the `message` variable the social user registration varies in two ways.


#### Case 1:

Case where the `message` variable is `new_registration_required` the user has to be registered to the business. 

The new social login user can be registered using the method `registerSocialUser` in the `SocialRegBuilder` instance.

```swift

socialRegBuilder.registerSocialUser(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)


```

The method `verifyRegOTP` and `resendRegOtp` should be used to verify the account and resend the otp for a new registration user.

    
```swift
    
socialRegBuilder.verifyRegOTP(otp: OTP, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
    
socialRegBuilder.resendRegOTP(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```

| Params | Description |
|--------|-------------|
| OTP | The otp sent to the phone number passed in the `verifyPhone` call |


#### Case 2:

For cases where the `message` variable is other than `new_registration_required`.

The user's phone number is already present in the system and needs to be verified. 

The methods `verifySocialOTP` and `resendSocialOTP` should be used to verify phone number and resend the otp for an user's phone number already present in the system.

```swift

socialRegBuilder.verifySocialOTP(otp: String, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
    
socialRegBuilder.resendSocialOTP(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```

Note: Once a user has successfully verified the otp the [social user login](#social-login) function should called to login the user.

<a name="user"></a>
## User

When an user log's in, the user's details are stored in the SDK, the `User` object stored by the SDK can be retrived by calling the `getUser()` method on the `sharedInstance()` of the UrbanPiper SDK.

```swift

let user: User = UrbanPiperSDK.sharedInstance().getUser()


```

Returns an user object if the user is logged in or else returns an `nil` reference.

# Usecases
<a name="how-to-get-catalog"></a>
## How to get catalog

The UrbanPiper order management system(OMS) allows you to configure categories, items, item prices, item stock etc on a store by store basis.

Therefore it's essential for the app to get the store nearest to the user before retriving the catalog from the server.

In cases where the users location services are disabled or when there are no store's near by the user the generic catalogue can be retrived from the server. The items returned from the generic catalogue cannot be added to the cart.


<a name="get-nearest-store"></a>
### How to get a store

To return the nearest store the user's location is required. The following method takes the users location and returns the nearest store if the user is within the deliverable area a store.

```swift

UrbanPiper.sharedInstance().getNearestStore(lat: USER-LOCATION-LATITUDE, lng: USER-LOCATION-LONGITUDE,
                                            completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                            
```

| Params | Description |
|--------|-------------|
| USER-LOCATION-LATITUDE | The users location latitude |
| USER-LOCATION-LONGITUDE | The users location longitude |


<a name="get-categories"></a>
#### Categories

The categories that are configured in your businesses OMS

##### Store specific categories
Store specific categories can be retrived by passing in the nearest id for the param `storeId`.

```swift

   UrbanPiper.sharedInstance().getCategories(storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, limit: PAGINATION-FETCH-LIMIT,
                                             completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                             
```

| Params | Description |
|--------|-------------|
| NEAREST-STORE-ID | The id of the store near by to the user |
| PAGINATION-OFFSET | `Default - 0` The offset from which the categories should be returned from. |
| PAGINATION-FETCH-LIMIT | `Default - 20` The number of categories to be fetched from the PAGINATION-OFFSET |

##### Generic categories

Generic categories can be retrived by passing a `nil` reference for the param `storeId`.

```swift

   UrbanPiper.sharedInstance().getCategories(storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, limit: PAGINATION-FETCH-LIMIT,
                                             completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                             
```

| Params | Description |
|--------|-------------|
| NEAREST-STORE-ID | `nil` reference |
| PAGINATION-OFFSET | `Default - 0` The offset from which the categories should be returned from. |
| PAGINATION-FETCH-LIMIT | `Default - 20` The number of categories to be fetched from the PAGINATION-OFFSET |

<a name="get-category-items"></a>
#### Get Category Items

The getCategoryItems function can be called with or without the `NEAREST-STORE-ID`, when called without the `NEAREST-STORE-ID` the api's returns items that are generic and cannot be added to the cart. Passing the `NEAREST-STORE-ID` returns items specific to the particular store.

```swift

   UrbanPiper.sharedInstance().getCategoryItems(categoryId: CATEGORY-ID, storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, 
                                                limit: PAGINATION-FETCH-LIMIT, sortBy: SORT-KEY, filterBy: FILTER-OPTIONS,
                                                completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                                
```

PAGINATION-OFFSET: Default - 0. The offset from which the categories or items should be returned from.<br />
PAGINATION-FETCH-LIMIT: Default - 20. The number of categories or items that can be fetched from the PAGINATION-OFFSET.<br />
SORT-KEY: User selected sort option key from getFilterAndSortOptions API.<br />
FILTER-OPTIONS: User selected filters options from getFilterAndSortOptions API.<br />

The getFilterAndSortOptions function returns a list of sorting keys and filter options for a given CATEGORY_ID that are supported by your business.

```swift
   UrbanPiper.sharedInstance.getFilterAndSortOptions(categoryId: CATEGORY-ID, completion: COMPLETION-CALLBACK, 
                                                     failure: FAILURE-CALLBACK)
```                                                     

<a name="item-option-builder"></a>
## Item Option Builder

ItemOptionBuilder is a helper class that simplifies the addition and removal of `ItemOption` for an item,
An item option is an variation of an item.
The item option group is used only in cases where the `Item.optionGroups` is non-nil.

```swift
   // The initializer methods returns the ItemOptionGroup helper class for adding item options.
   let itemOptionBuilder = ItemOptionBuilder(item: ITEM)

   // Returns the current value of the item including the base price and the value of the options added. 
   let amount = itemOptionBuilder.totalAmount
   
   // Code to add an option to the itemOptionBuilder
   do {
       try itemOptionBuilder.addOption(groupId: OPTIONGROUPID, option: ITEMOPTION)
       // Option has been added.
   } catch ItemOptionBuilderError.maxItemOptionsSelected(let maxCount) {
       // The max number of options has been added for the provided group id
   } catch {
       // This should not happen
       print("Unexpected error: \(error).")
   }
   
   // Once the necessary `ItemOption` are added the build method returns an `CartItem` object that can be added to the cart
   do {
        let cartItem = try itemOptionBuilder.build()
        // The cartItem can be added to the cart
   } catch ItemOptionBuilderError.invalid(let group) {
        // Error thrown indicates that a group has option addtions below the minSelectable variable or additions above the maxSelectable variable.
   } catch {
        // This should not happen.
        print("Unexpected error: \(error).")
   }
```

ITEM: An instance of item object from the getCategoryItems API result.

<a name="cart"></a>
## Cart

The following are functions to call to add an item to the cart.<br />
Note: to add an item with option groups the [ItemOptionBuilder](#item-option-builder) should be used to generate the cart item.

```swift
   // The initializer methods returns a cart item that can be added to the Cart.
   let cartItem = CartItem(item: item)
   let cartItem = CartItem(reorderItem: item)

   // Adds the cartItem to the cart.
   do {
      try UrbanPiper.sharedInstance().addItemToCart(cartItem: cartItem, quantity: 1)
      // cartItem has been added to the cart.
   } catch CartError.itemQuantityNotAvaialble(let maxOrderCount) {
      // Error thrown indicates that the item quantity passed and the current cart item count is higher than the `Item.currentStock` of the item.
   } catch {
      // This should not happen.
      print("Unexpected error: \(error).")
   }
```

ITEM: An instance of item object from the getCategoryItems API result.
REORDERITEM: An instance of reorderItem object from the reorder API result.

<a name="Ordering"></a>
## Ordering

To place an order the `CheckoutBuilder` class needs to be initialized. checkout builder contains the relevant API calls to place an order

```swift
   // Initializes an instance of CheckoutBuilder
   let checkoutBuilder: CheckoutBuilder = UrbanPiper.sharedInstance().startCheckout()
   
   // Returns an list of supported payment options, this call returns the supported payment options only when the validateCart function has been called atleast once else it returns an `nil`.
   var paymentOptionsArray = checkoutBuilder.getPaymentModes()
   
   // Clears the coupon that has been applied.
   checkoutBuilder.clearCoupon()
```

The following are the steps to be followed to place an order.

#### Step 1:

API call to validate the items in cart, get the supported payments options, get order details such as taxes, delivery charges, payment charges etc.

This API should be called whenever a cart item is added, removed.

Calling this API invalidates the previous calls to `validateCoupon(...)`, and `initPayment(...)`, the response values of both the calls should be discarded.

```swift
   checkoutBuilder.validateCart(store: NEAREST-STORE, useWalletCredits: USER-WALLET-CREDIT, deliveryOption: DELIVERY-OPTION, 
                                cartItems: CARTITEMS, orderTotal: CARTTOTAL, completion: COMPLETION-CALLBACK, 
                                failure: FAILURE-CALLBACK)
```

NEAREST-STORE: The store where the order is to be placed..<br />
USER-WALLET-CREDIT: Setting this as `true` enable split payment where wallet amount is used for payment first and the balance amount from the payment option selected by the user.<br />
DELIVERY-OPTION: Delivery optin selected by the user.<br />
CARTITEMS: The list of cart items added to card, retrived using UrbanPiper.sharedInstance().getCartItems().<br />
CARTTOTAL: The total value of all the items in cart, retrived using UrbanPiper.sharedInstance().getCartValue().

#### Step 2:

API call to validate the coupon code applied by the user. 

When ever a validateCart API call is made the previous validateCoupon response is invalidated. To re-apply the coupon call this API after the completion of the validateCart API call.  

```swift                                                                
    checkoutBuilder.validateCoupon(code: COUPONCODE, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

#### Step 3:

This API call returns the details on the payment option passed in. This step can be skipped for the payment option `cash` and the placeOrder API can be called directly.

```swift                                                                
    checkoutBuilder.initPayment(paymentOption: PAYMENT-OPTION, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

PAYMENT-OPTION: Payment option selected by the user.

#### Step 4:

API call places the order in the store passed in the validateCart API with the cart items from the same.

```swift                                                                
    checkoutBuilder.placeOrder(address: ADDRESS, deliveryDate: DELIVERY-DATE, deliveryTime: DELIVERY-TIME, timeSlot: TIMESLOT, 
                               paymentOption: PAYMENT-OPTION, instructions: INSTRUCTIONS, phone: PHONE-NUMBER,
                               completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

ADDRESS: Address to delivered.<br />
DELIVERY-DATE: The date at which the item is to delivered.<br />
DELIVERY-TIME: The time at which the item is to be delivered.<br />

TIMESLOT: Optional. Only needs to be set when time slots are used. The timeslot selected by the user to deliver at.<br />

The available time slots can be retrived from the [nearest store api](#catalog), the api result `StoreResponse` contains two varibles `Biz` and `Store`.<br />

The time slots available in the Store object represents the time slots set on a store level, if there are no time slot objects in the Store object use the time slots from the Biz which are the time slots configured at Biz level.<br />

PAYMENT-OPTION: Payment option selected by the user.<br />
INSTRUCTIONS: Instructions to be sent to the store.<br />
PHONE-NUMBER: Phone number of the user.

#### Step 5:

API call to verify the payment transaction when the PAYMENT-OPTION is `paymentGateway`, for other payment options this function can be skipped.

```swift                                                                                                              
    checkoutBuilder.verifyPayment(pid: PAYMENT-ID, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

PAYMENT-ID: The id returned by the 3rd party payment provider on successfull payment completion.