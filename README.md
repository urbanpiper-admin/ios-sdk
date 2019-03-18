
[![CocoaPods Compatible](http://img.shields.io/cocoapods/v/urbanpiper-swift.svg)](https://urbanpiper.com)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)

# Table of Contents

<!-- MarkdownTOC -->

- [Introduction](#introduction)    
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Carthage](#carthage)
- [Initialization](#initialization)
- [User](#user)
- [Authentication](#authentication)
    - [Login](#login)
    - [Social user login](#social-login)
- [User registration](#user-registration)
    - [Registration](#registration)
    - [Social user registration](#social-registration)
- [Catalogue](#catalogue)
- [Item Option Builder](#item-option-builder)
- [Cart](#cart)
- [Ordering](#ordering)

<!-- /MarkdownTOC -->

<a name="introduction"></a>
# Introduction

The Urban piper ios SDK is written in swift.

<a name="installation"></a>
# Installation

<a name="cocoapods"></a>
## CocoaPods

UrbanPiper supports `CocoaPods` for easy installation.
To Install, see our **[swift integration guide »](https://UrbanPiper.com/help/reference/swift)**

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
    UrbanPiper.intialize(language: APP-LANGUAGE, bizId: URBANPIPER-BIZID, apiUsername: URBANPIPER-API-USERNAME, 
                         apiKey: URBANPIPER-API-KEY, callback: CALLBACK)
    ...
}
```

You initialize the UrbanPiper instance with the params lanuguage, bizId, apiUsername, apiKey, callback

APP-LANGUAGE: Optional. Default - english. The `Language` the server should send the data.<br />
URBANPIPER-BIZID: your business id from urbanpiper.<br />
URBANPIPER-API-USERNAME: your api username from urbanpiper.<br />
URBANPIPER-API-KEY: your api key from urbanpiper.<br />
CALLBACK: callback notifies about the `SDKEvent` that should be handled by the app.<br />

<a name="user"></a>
## User

Once the SDK has been initialized the user object can be accessed from the SDK by calling the function below, returns an user object if a user is logged in else return an nil.

```swift
   UrbanPiperSDK.sharedInstance().getUser()
```

<a name="authentication"></a>
## Authentication

<a name="login"></a>
### Login
    
An User can be logged in by calling the function below with the relevant params.

```swift
   UrbanPiper.sharedInstance().login(phone: PHONE-NUMBER, password: PASSWORD, 
                                     completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

PHONE-NUMBER: The phone number passed in should be prefixed with the user's country code

Once a user has successfully logged in the user object can be accessed by the SDK's [getUser()](#user) function

<a name="social-login"></a>
### Social User Login
    
For a Social User Login the function below should be called with the relevant params

```swift
   UrbanPiper.sharedInstance().socialLogin(email: EMAIL, socialLoginProvider: PROVIDER, accessToken: PROVIDER-ACCESS-TOKEN,         
                                           completion:COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

COMPLETION-CALLBACK: In the completion callback the `SocialLoginResponse` object is returned, the object contains the `message` and `success` variables, if the success variable is `true` then the social login was successfull, if the success variable is `false` then the message variable provides you info on what it do next.

if the message is `phone_number_required` the phone number of the social login user has to be veriifed, this can be done by following the steps mentioned in [Social User Registration](#social-registration)


PROVIDER: The currently supported providers are Google and Facebook<br />
PROVIDER-ACCESS-TOKEN: The token that is provided by the PROVIDER on successful login

<a name="user-registration"></a>
## User registration

<a name="registration"></a>
### Registration
    
Registering an user is a two step process, the user has to be registered using the registerUser api and then verify the account with the otp sent to the user's phone by calling the verifyRegOTP api

```swift
   // This returns an registration builder object that contains the relevant api call to register an user
   let registrationBuilder: RegistrationBuilder = UrbanPiper.sharedInstance().startRegistration()
   
   // Register an account with your business
   registrationBuilder.registerUser(phone: PHONE-NUMBER, name: USERNAME, email: EMAIL, password: PASSWORD, 
                                    completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
   // Verify the account with the otp sent to the user's phone number
   // The phone number passed in should be prefixed with the user's country code
   registrationBuilder.verifyRegOTP(phone: PHONE-NUMBER, otp: OTP, email: EMAIL, password: PASSWORD, 
                                    completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

OTP: The otp sent is sent to the phone number passed in the registerUser call

Once a user's otp has been verifed successfully the [login](#login) function should to used to login the user.

<a name="social-registration"></a>
### Social User Registration

Registering an social user starts with an call to verifyPhone number.

```swift
   // This returns an social registration builder object that contains the relevant api calls to register an social login user
   let socialRegBuilder: SocialRegBuilder = UrbanPiper.sharedInstance().startSocialRegistration()

    // API call check if the passed in phone number is present in the system
    socialRegBuilder.verifyPhone(name: USERNAME, phone: PHONE-NUMBER, email: EMAIL, gender: GENDER, provider: PROVIDER,        
                                 providerAccessToken: PROVIDER-ACCESS-TOKEN, completion: COMPLETION-CALLBACK, 
                                 failure: FAILURE-CALLBACK)
```

Based on the result of the verifyPhone api call the social user registration varies in two way.

The verifyPhone api returns an `RegistrationResponse` object, the object contains the `message` variable

Case where the message variable is `new_registration_required` the user has to be registered to the business by calling the function `registerSocialUser` and the functions `verifyRegOTP` and `resendRegOtp` should be used to used to verify the account and resend the otp.

#### Case 1:
    
```swift
   socialRegBuilder.registerSocialUser(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
    
   socialRegBuilder.verifyRegOTP(otp: OTP, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
    
   socialRegBuilder.resendRegOTP(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

For cases where the message variable is other than `new_registration_required` the phone number is already present in the system and the user's phone number needs to be verified using the functions verifySocialOTP and to resend a new otp the function resendSocialOTP should be used.

#### Case 2:

```swift
	socialRegBuilder.verifySocialOTP(otp: String, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
    
   socialRegBuilder.resendSocialOTP(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

Once a user has successfully verified the otp the [social user login](#social-login) function should called to login the user.

<a name="catalogue"></a>
## Catalogue

The getNearestStore function returns the store details nearest to the user's location, if there is no stores present nearby the store object is nil

```swift
   UrbanPiper.sharedInstance().getNearestStore(lat: USER-LOCATION-LATITUDE, lng: USER-LOCATION-LONGITUDE,
                                               completion: COMPLETION-CALLBACK,
                                               failure: FAILURE-CALLBACK)
```

The getCategories function can be called with or without the `NEAREST-STORE-ID`, when called without the `NEAREST-STORE-ID` the api's returns categories that are generic and cannot be added to the cart. Passing the `NEAREST-STORE-ID` returns categories specific to the particular store.


```swift
   UrbanPiper.sharedInstance().getCategories(storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, limit: PAGINATION-FETCH-LIMIT,
                                             completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

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

ItemOptionBuilder is a helper class that simplifys the addition and removal of `ItemOption` for an item, The item option group is used only in cases where the `Item.optionGroups` is non-nil.

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

The following are functions to call to add an item to the cart.

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

The available time slots can be retrived from the [nearest store api](#catalogue), the api result `StoreResponse` contains two varibles `Biz` and `Store`.<br />

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