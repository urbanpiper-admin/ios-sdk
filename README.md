
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

* [Initalizing the SDK](#initialization) <br>
The SDK is [initialized](#initialization) with the params `biz id`, `api username` and `api key` provided by UrbanPiper. if you don't have the keys you can contact urbanpiper at `support@urbanpiper.com` to get the keys for your business.

* [Logging in a user](#login) <br>
An User can login to your business by performing an [phone based login](#phone-based-login) or a [social user login](#social-login).

* [Registering a new user](#registration) <br>
A new account can be registered in your business either by performing a [phone based registration](#phone-based-registration) or by a [social registration](social-registration).

* [How to get the catalog](#catalog) <br>
To get the nearest store the user's location is required. with the user's location the [nearest store](#get-nearest-store) can be retrived from the server. <br>
With the nearest store the store specific [categories](#get-categories) can be retrived from the server. <br>
The [items](#get-category-items) for a specific store and category can be retrived from the server using the Store and Category details retrived previously.

* [Managing your cart](#cart) <br>
The store specfic items can be added to the [cart](#add-to-cart).<br />
Note: to add an item with option groups the [ItemOptionBuilder](#item-option-builder) should be used to generate the cart item.

* [Placing an order](#ordering)
 


<a name="installation"></a>
# Installation & Initialization 

## Installation

UrbanPiper SDK can be installed through either of the two approches: 

<a name="cocoapods"></a>
### CocoaPods


Here are the steps to install UP SDK with CocoaPods: 

- Install CocoaPods (Installation Guide)
- Integrate CocoaPods in you projects (Integration Guide)
- Add the pod for UrbanPiper SDK <br> `pod 'UrbanPiper'`
- Install your dependancies by running the following command in your project directory <br> `pod install`



<a name="carthage"></a>
### Carthage

UHere are the steps to install UP SDK with CocoaPods: 

`github "urbanpiper/ios-sdk"`

Check out the **[Carthage docs »](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)** for more info. 

<a name="initialization"></a>
## Initialization

Import the UrbanPiper module into AppDelegate.swift, and initialize UrbanPiper SDK inside the `application:didFinishLaunchingWithOptions:` method

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
| APP-LANGUAGE | `Optional` <br>This is the language the server should send the data in. Default is `english` |
| URBANPIPER-BIZID | This is your Business ID in UrbanPiper System. |
| URBANPIPER-API-USERNAME | This is your API Username in Urbanpiper System.  |
| URBANPIPER-API-KEY | This is your API Key in UrbanPiper System. |
| CALLBACK | Callback notifies about the `SDKEvent` that should be handled by the app. |

> Note: `URBANPIPER-BIZID`, `URBANPIPER-API-USERNAME` & `URBANPIPER-API-KEY` are essential to initionalise the SDK. If you don't have them, please reach out to our support team (support@urbanpiper.com) & we'll set you up. 

Once the SDK is initialized, the shared instance of the SDK can be accessed by the class method `UrbanPiper.sharedInstance()`


<a name="user-and-authentication"></a>
# Users & Authentication

There are four major use-cases w.r.t User & Authentication: 

- Login an existing User 
- Reset password for an exisiting User 
- Registering a new User 
- Retreving the user data for a logged-in user 


<a name="login"></a>
## Login an existing User 

There are two ways Users can login:

* Phone number based login.
* Social login.


<a name="phone-based-login"></a>
### Phone number based login

With a combination of registered phone number and saved password, a user can login into the app. Here is how the login method can be called: 

```swift

UrbanPiper.sharedInstance().login(phone: PHONE-NUMBER, password: PASSWORD, completion: COMPLETION-
										CALLBACK, failure: FAILURE-CALLBACK)
										
```

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| PASSWORD | Password entered by the user |
| COMPLETION-CALLBACK | The completion callback is called when the method call succeeds |
| FAILURE-CALLBACK | The failure callback is called if the method call fails  |


<a name="social-login"></a>
### Social login

UP system currently support Social Login via - Google & Facebook

The setup for social login providers are out of scope of this document, but below are the links that might be useful: 

* Google Sign in: **[Google sign in integration guide »](https://developers.google.com/identity/sign-in/ios/)**
* Facebook Login: **[Facebook login integration guide »](https://developers.facebook.com/docs/facebook-login/ios/)**

        
Once the social login flow of the selected provider (Google/Facebook) is completed the user can be logged in by calling the following method:

```swift

UrbanPiper.sharedInstance().socialLogin(email: EMAIL, socialLoginProvider: PROVIDER, accessToken: PROVIDER-ACCESS-TOKEN, 
										completion:COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                           
```

| Params | Description |
|--------|-------------|
| EMAIL | User's email id from the social login provider (Google/ Facebook) |
| PROVIDER | The social login method selected by the user (`.google` or `.facebook`) |
| PROVIDER-ACCESS-TOKEN | The access token returned by the social login provider (Google/ Facebook) |
| COMPLETION-CALLBACK | The completion callback is called when the method call succeeds |
| FAILURE-CALLBACK | The failure callback is called if the method call fails  |

> Note: The completion callback returns the `SocialLoginResponse` object with the variables `message` and `success`. 

* if the success variable is `true` then the social login was successfull.
* if the success variable is `false` and the message variable is `phone_number_required` the user has to go through the social registration flow .

Jump to [Social Registration Flow](#social-registration) to understand the steps required to register a social login user. 

<a name="reset-password"></a>
## Reset password for an existing User 

If the user has forgotten his/her password, the password can be reset using the `ResetPasswordBuilder`. 

An instance of `ResetPasswordBuilder` can be accessed by calling the method below:

```swift

let resetPasswordBuilder: ResetPasswordBuilder = UrbanPiper.sharedInstance().startResetPassword()
   
```

Resetting the password using the `ResetPasswordBuilder` is a two steps process: 

#### Step 1: Validating User
With the entered phone-number, UrbanPiper System checks if the user exists. Following method can be called for that: 

```swift

resetPasswordBuilder.forgotPassword(phone: PHONE-NUMBER, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |

If the user exists, an `OTP` is sent to the registered phone number. Else, it returns an error. 

#### Step 2: Resetting Password
Using the `OTP`, recieved in the previous step, the following method can be called to reset the password: 

```swift

resetPasswordBuilder.resetPassword(otp: OTP, password: NEW-PASSWORD, confirmPassword: NEW-CONFIRMATION-PASSWORD, 
								   completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```

| Params | Description |
|--------|-------------|
| OTP | The `otp` sent to the phone number recieved in the previous step |
| NEW-PASSWORD | The new password of the user |
| NEW-CONFIRMATION-PASSWORD | The new confirmation password of the user |

<a name="registration"></a>
## Registering a new User

A user can be registered in either of the two ways: 

* Phone number based registration.
* Social Registration.

<a name="registration"></a>
### Phone number based registration

A User can be registered with a phone number, using the `RegistrationBuilder`. 

An instance of `RegistrationBuilder` can be accessed by calling the following method:


```swift

let registrationBuilder: RegistrationBuilder = UrbanPiper.sharedInstance().startRegistration()
   
```
    
User registration is a two step process: 


#### Step 1: Initiate User registration

The user registration can be initiated by calling the following method:

```swift
   
registrationBuilder.registerUser(phone: PHONE-NUMBER, name: USERNAME, email: EMAIL, password: PASSWORD, 
                                 completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                    
```                                    

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| USERNAME | The entered name of the user |
| EMAIL | The email id entered by the user |
| PASSWORD | Password entered by the user |


#### Step 2: Verify the account 
Using the `OTP`, recieved in the previous step, the following method can be called to verify the account

```swift

registrationBuilder.verifyRegOTP(phone: PHONE-NUMBER, otp: OTP, email: EMAIL, password: PASSWORD, 
                                 completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                    
```

| Params | Description |
|--------|-------------|
| PHONE-NUMBER | Phone number of the user prefixed with the user's country code |
| OTP | The otp sent to the phone number passed in the `registerUser` call |

> Note: Once a user's `otp` has been verifed successfully the user can be logged into the sytem by using the [login](#login) method.

<a name="social-registration"></a>
### Social Registration

> Note: The Social User Registration should only the initiated when the `success` variable in the [social login](#social-login) response is `false` and the `message` variable of the response is `phone_number_required`.

A User can be registered with a social login provider, using the `SocialRegBuilder`. 

An instance of `SocialRegBuilder ` can be accessed by calling the following method:

```swift

let socialRegBuilder: SocialRegBuilder = UrbanPiper.sharedInstance().startSocialRegistration()
   
```

Registering a new social user starts with the method call to verify the phone number.

```swift

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


If the `COMPLETION-CALLBACK` is called then it'll return a `RegistrationResponse` object with the variable `message`.

Based on the value of the `message` variable the social user registration can have two cases.


#### Case 1: Message is `new_registration_required`

In this case the user has to be registered and the `OTP` has to be verified

The new social login user can be registered using the method `registerSocialUser` in the `SocialRegBuilder` instance.

```swift

socialRegBuilder.registerSocialUser(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
 
```

Once the user is registered successfully, then an OTP will be sent to the user from UrbanPiper sytem. 

Use the following method to verify OTP:

```swift
    
socialRegBuilder.verifyRegOTP(otp: OTP, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```


| Params | Description |
|--------|-------------|
| OTP | The otp sent to the phone number passed in the `verifyPhone` call |


In case the user hasn't recieved the OTP, another OTP can be requested with the following method:

```swift
    
socialRegBuilder.resendRegOTP(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```


#### Case 2: Message is something other than `new_registration_required`

In this case the user is already registered and only `OTP` verification is required. Here the `OTP` would have already been sent in the `verifyPhone` method call.

Use the following method to verify the `OTP`

```swift

socialRegBuilder.verifySocialOTP(otp: String, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
 
```

In case the user hasn't recieved the OTP, another OTP can be requested with the following method:

```swift
    
socialRegBuilder.resendSocialOTP(completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
   
```

> Note: Once a user has successfully verified the otp the [social user login](#social-login) method should called to login the user.

<a name="user"></a>
## Retrieving the user data for a logged-in user 

When a user is logged in, the user's details are stored in the SDK, 

The `User` object stored by the SDK is accessible by the following method

```swift

let user: User = UrbanPiperSDK.sharedInstance().getUser()
 
```

> Note: Returns an user object if the user is logged in or else returns an `nil` reference.

# Usecases
<a name="how-to-get-catalog"></a>
## How to get catalog

The UrbanPiper order management system(OMS) allows you to configure categories, items, item prices, item stock etc on a store by store basis.

Therefore it's important for the app to get the store nearest to the user before retriving the catalog from the server.

The genric catalogue should be displayed when there are no stores near by to the user or if the app does not have the users location due location services being disabled or because of failure in retriving the users location. The generic catalogue items cannot be added to the cart.


<a name="get-nearest-store"></a>
### How to get a store

To get the nearest store the user's location is required. The following method takes the users location and returns the nearest store if the user is within the deliverable area the store.

Note: When the nearest store is retrived the categories, category items and the cart associated with the previous store must be discared as the categories and category items differ on a store by store basis.

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

Retriving the categories that are configured in your businesses OMS on the business level(generic) and on store by store basis.

<a name="store-specific-categories"></a>
##### Store specific categories
Store specific categories can be retrived by passing in the `Store.bizLocationId` of the store nearest to the user for the param `storeId` in the following method.

```swift

   UrbanPiper.sharedInstance().getCategories(storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, limit: PAGINATION-FETCH-LIMIT,
                                             completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                             
```

| Params | Description |
|--------|-------------|
| NEAREST-STORE-ID | The `Store.bizLocationId` of the store near by to the user |
| PAGINATION-OFFSET | `Default - 0` The offset from which the categories should be returned from. |
| PAGINATION-FETCH-LIMIT | `Default - 20` The number of categories to be fetched from the PAGINATION-OFFSET |

<a name="generic-categories"></a>
##### Generic categories

Generic categories are retrived by passing a `nil` reference for the param `storeId` in the following method.

```swift

UrbanPiper.sharedInstance().getCategories(storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, limit: PAGINATION-FETCH-LIMIT,
                                          completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                             
```

| Params | Description |
|--------|-------------|
| NEAREST-STORE-ID | `nil` reference |
| PAGINATION-OFFSET | `Default - 0` The offset from which the categories should be returned from. |
| PAGINATION-FETCH-LIMIT | `Default - 20` The number of categories to be fetched from the PAGINATION-OFFSET |

<a name="filter-and-sort-options"></a>
#### Filter and sort options

UrbanPiper SDK supports filtering and sorting of items on a category by category basis, the supported filter and sort options for a given category can be retrived from the server using the method below.

```swift
UrbanPiper.sharedInstance.getFilterAndSortOptions(categoryId: CATEGORY-ID, 
												  completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```                                                     
| Params | Description |
|--------|-------------|
| CATEGORY-ID | The `ItemCategory.id` for which the filter and sort options are to be retrived |


<a name="get-category-items"></a>
#### Get Category Items

Retriving the category items that are configured in your businesses OMS on the business level(generic) and on store by store basis.

<a name="store-specific-category-items"></a>
##### Store specific category items

Store specific categories can be retrived by passing in the `Store.bizLocationId` of the store nearest to the user for the param `storeId` and the `ItemCategory.id` for the param `categoryId` in the following method.

```swift

UrbanPiper.sharedInstance().getCategoryItems(categoryId: CATEGORY-ID, storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, 
                                             limit: PAGINATION-FETCH-LIMIT, sortBy: SORT-KEY, filterBy: FILTER-OPTIONS,
                                             completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                                
```


| Params | Description |
|--------|-------------|
| NEAREST-STORE-ID | The `Store.bizLocationId` of the store near by to the user |
| CATEGORY-ID | The `ItemCategory.id` for which the item are to be retrived |
| PAGINATION-OFFSET | `Default - 0` The offset from which the items should be returned from |
| PAGINATION-FETCH-LIMIT | `Default - 20` The number of items to be fetched from the PAGINATION-OFFSET |
| SORT-KEY | User selected sort key from [filter and sort options](#filter-and-sort-options) |
| FILTER-OPTIONS | User selected filter options from [filter and sort options](#filter-and-sort-options) |

<a name="generic-category-items"></a>
##### Generic category items

Generic category items are retrived by passing a `nil` reference for the param `storeId` and the `ItemCategory.id` of the category for the param `categoryId` in the following method.

```swift

UrbanPiper.sharedInstance().getCategoryItems(categoryId: CATEGORY-ID, storeId: NEAREST-STORE-ID, offset: PAGINATION-OFFSET, 
                                             limit: PAGINATION-FETCH-LIMIT, sortBy: SORT-KEY, filterBy: FILTER-OPTIONS,
                                             completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                                                
```


| Params | Description |
|--------|-------------|
| NEAREST-STORE-ID | `nil` reference |
| CATEGORY-ID | The `ItemCategory.id` for which the item are to be retrived |
| PAGINATION-OFFSET | `Default - 0` The offset from which the items should be returned from |
| PAGINATION-FETCH-LIMIT | `Default - 20` The number of items to be fetched from the PAGINATION-OFFSET |
| SORT-KEY | User selected sort key from [filter and sort options](#filter-and-sort-options) |
| FILTER-OPTIONS | User selected filter options from [filter and sort options](#filter-and-sort-options) |


<a name="cart"></a>
# How to build a cart
## Building an cart item
There are three way to generate an cart item

* From an store specific item with no option groups.
* From an reorder item.
* From an store specific item with option groups.

### From a store specific item with no option groups
The cart item can be initialized from a store specific item using the `CartItem` initializer that takes a `Item` object as an parameter.

```swift

let cartItem: CartItem = CartItem(item: ITEM)
 
```

### From a reorder item

The cart item can be initialized from a reorder item using the `CartItem` initializer that takes a `ReorderItem` object as an parameter.

```swift

let cartItem: CartItem = CartItem(reorderItem: REORDERITEM)
 
```

### From a store specific item with option groups

The cart item can be generated from an store specific item with option groups using the `ItemOptionBuilder` 

`ItemOptionBuilder` is an helper class that simplifies the addition and removal of `ItemOption` for an item.<br />

An `ItemOption` is an variation of an item (e.g. 200 gms small, 500 gms medium, 1 kg large etc...). It could also be additional extras to the base item (e.g. Garlic mayonnaise, Peri peri mayonnaise, Tomato Ketchup etc...)<br />

The item option group should be used only in cases where the `Item.optionGroups` is `non-nil` and option group count is greater than zero.

#### Step 1:
Initializing an `ItemOptionBuilder` with the [store specific category items](#store-specific-category-items)

```swift

// The initializer methods returns the ItemOptionGroup helper class for adding item options.
let itemOptionBuilder = ItemOptionBuilder(item: ITEM)
 
```

| Params | Description |
|--------|-------------|
| ITEM | A store specific category item with `Item.optionGroups` is `non-nil` and option group count is greater than zero. |

#### Step 2:
Adding an `ItemOption` to the item, the method to add the option in the `ItemOptionBuilder` can throw error when the number of options added to a group is greater than the maximum number of options that can be added to the group.

If the group is single selection group where the `ItemOptionGroup.maxSelectable` is `1` the previously added option is removed and the new option is added.


```swift
   
// Code to add an option to the itemOptionBuilder
do {
    try itemOptionBuilder.addOption(groupId: OPTION-GROUP-ID, option: ITEMOPTION)
    // Option has been added.
} catch ItemOptionBuilderError.maxItemOptionsSelected(let maxCount) {
    // The max number of options has been added for the provided group id
} catch {
    // This should not happen
    print("Unexpected error: \(error).")
}
 
```

| Params | Description |
|--------|-------------|
| OPTION-GROUP-ID | The `ItemOptionGroup.id` of the group the `ITEMOPTION` belongs to. |
| ITEMOPTION | An option from the `ItemOptionGroup` |

   
#### Step 3:
Building the cart item, the `ItemOptionBuilder` provides the `build()` method that returns an `CartItem` when the option are according to the restrictions defined by the variables `ItemOptionGroup.minSelectable` and `ItemOptionGroup.maxSelectable` of the group.

The `build()` method returns an instance of `CartItem`, this can be added to the cart.

If there are any invalid group that don't satisify the restrictions set for the group, the `build()` method of the `ItemOptionBuilder` throws an error with the first invalid group the builder finds.


```swift

// Once the necessary `ItemOption` are added the build method returns an `CartItem` object that can be added to the cart
do {
    let cartItem = try itemOptionBuilder.build()
    // The cartItem can be added to the cart
} catch ItemOptionBuilderError.invalid(let group) {
    // Error thrown indicates that a group has option addtions below the minSelectable variable
} catch {
    // This should not happen.
    print("Unexpected error: \(error).")
}
 
```

#### Other methods

##### Removing an option
Removes an option previously added to the `ItemOptionBuilder`

```swift

itemOptionBuilder.removeOption(groupId: GROUP-ID, option: ITEMOPTION)
 
```

| Params | Description |
|--------|-------------|
| OPTION-GROUP-ID | The `ItemOptionGroup.id` of the group the `ITEMOPTION` belongs to. |
| ITEMOPTION | An option from the `ItemOptionGroup` |

##### Value of item with options 
Returns the current value of the item including the base price and the value of the options added. 

```swift

let amount: Decimal = itemOptionBuilder.totalAmount
 
```

##### Options added to the group 
Returns the number of options added to the given groip particular group. 

```swift

let selectedOptionsForGroup: [ItemOption] = selectedOptionsFor(groupId: GROUP-ID)
 
```

| Params | Description |
|--------|-------------|
| OPTION-GROUP-ID | The `ItemOptionGroup.id` of the group. |


## Adding an cart item to cart


The `addItemToCart` takes an instance of `CartItem` as the parameter.

The generated instance of `CartItem` can be added to the cart using the instance method `addItemToCart` in the `sharedInstance()` of UrbanPiper SDK

```swift

// Adds the cartItem to the cart.
do {
	 try UrbanPiper.sharedInstance().addItemToCart(cartItem: CARTITEM, quantity: QUANTITY)
     // cartItem has been added to the cart.
} catch CartError.itemQuantityNotAvaialble(let availableStock) {
     // Error thrown indicates that the item quantity passed and the current cart item count is higher than the `Item.currentStock` of the item. The available is the number of items that can be add to the cart.
} catch {
     // This should not happen.
     print("Unexpected error: \(error).")
}
 
```

| Params | Description |
|--------|-------------|
| CARTITEM | An instance of `CARTITEM`. |
| QUANTITY | The quantity of the CARTITEM to add. |

## Other methods:

### Removing an item
Removes an cartitem added to the cart that was previously added

```swift

UrbanPiper.sharedInstance().removeOption(groupId: GROUP-ID, option: ITEMOPTION)
 
```

| Params | Description |
|--------|-------------|
| GROUP-ID | The `ItemOptionGroup.id` of the group the `ITEMOPTION` belongs to. |
| ITEMOPTION | An option from the `ItemOptionGroup` |

### Cart items
Returns the list of items added to the cart

```swift

let myCartItems: [CartItem] = UrbanPiper.sharedInstance().getCartItems()
 
```

### Cart value
Returns the total value of the cart items including the options added

```swift

let myCartValue: Decimal = UrbanPiper.sharedInstance().getCartValue()
 
```

### Cart count
Returns the total quanity of items added to the cart(e.g. if cart contains one cart item with quantity of `3`, then this method returns the `3`).

```swift

let myCartCount: Decimal = UrbanPiper.sharedInstance().getCartValue()
 
```

### Cart count for an item
Returns the item count in the cart without factoring in the varients.

If an item has 3 different varients and each of the 3 variants are added to the cart with a quantites of 3, 2, 1, the cart will contain 3 items, in this case this method returns the item count in the cart as 6 without factoring in the varients.

```swift

let myItemCount: Decimal = UrbanPiper.sharedInstance().getItemCountFor(itemId: ITEMID)
 
```

| Params | Description |
|--------|-------------|
| ITEMID | The `Item.id` for which the item count need to be returned. |


### Clear cart
Removes all the cart items in the cart.

Note: This cart should cleared using this method when the store associated with the cart changes to remove the items associated with the previous `store` as items are unique on a store by store basis.

```swift

UrbanPiper.sharedInstance().clearCart()
 
```

<a name="Ordering"></a>
# Checkout workflow
## Placing an order

Placing an order involves a number of steps and they vary based on the options selected by the user.

For placing an order the builder approach has been taken, to get an instance of `CheckoutBuilder` needed to place an order the following method should be called on the `sharedInstance()` of the SDK.

```swift

   // Initializes an instance of CheckoutBuilder
   let checkoutBuilder: CheckoutBuilder = UrbanPiper.sharedInstance().startCheckout()
   
```

The following steps are to be followed to place an order.

#### Step 1:

Validate the items in cart, get the supported payments options, get order details such as taxes, delivery charges, payment charges etc.

This methods should be called whenever a cart item is added, removed.

Calling this method invalidates the previous calls to `validateCoupon(...)`, and `initPayment(...)`, the response values of both the calls should be discarded.

```swift

checkoutBuilder.validateCart(store: NEAREST-STORE, useWalletCredits: USER-WALLET-CREDIT, 
							 deliveryOption: DELIVERY-OPTION, cartItems: CARTITEMS, orderTotal: CARTTOTAL,
							 completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
								     
```

|        Params      | Description |
|--------------------|-------------|
| NEAREST-STORE | The store where the order is to be placed. |
| USER-WALLET-CREDIT | Setting this as `true` enable split payment where wallet amount is used for payment first and the balance amount from the payment option selected by the user. |
| DELIVERY-OPTION | Delivery option selected by the user. |
| CARTITEMS | The list of cart items added to card, retrived using UrbanPiper.sharedInstance().getCartItems(). |
| CARTTOTAL | The total value of all the items in cart, retrived using UrbanPiper.sharedInstance().getCartValue(). |

#### Step 2:

Validate the coupon code applied by the user. 

When ever a validateCart API call is made the previous `validateCoupon` response is invalidated. To re-apply the coupon call this method again after the completion of the `validateCart` method call.  

```swift         
                                                       
checkoutBuilder.validateCoupon(code: COUPONCODE, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
 
```

| Params | Description |
|--------|-------------|
| COUPONCODE | The coupon code to be applied. |

#### Step 3:

This API call returns the details on the payment option passed in. This step can be skipped for the payment option `cash` and the placeOrder API can be called directly.

```swift   
                                                             
checkoutBuilder.initPayment(paymentOption: PAYMENT-OPTION, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
 
```

| Params | Description |
|--------|-------------|
| PAYMENT-OPTION | Payment option selected by the user |

#### Step 4:

Place the order with the selected options, for payment option `cash` this method can be called directly without calling the `initPayment` method.

For payment options other than cash the `payment option` should be the same as the one passed in `initPayment`

```swift   
                                                             
checkoutBuilder.placeOrder(address: ADDRESS, deliveryDate: DELIVERY-DATE, deliveryTime: DELIVERY-TIME, 
						   timeSlot: TIMESLOT, paymentOption: PAYMENT-OPTION, instructions: INSTRUCTIONS, 
						   phone: PHONE-NUMBER, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
                               
```

| Params | Description |
|--------|-------------|
| ADDRESS | Address the item should be delivered |
| DELIVERY-DATE | The date at which the item is to delivered |
| DELIVERY-TIME | The time at which the item is to be delivered |
| TIMESLOT | `Optional` Only needs to be set when time slots are used. The timeslot selected by the user to deliver at |
| PAYMENT-OPTION | Payment option selected by the user |
| INSTRUCTIONS | Instructions to be sent to the store |
| PHONE-NUMBER | Phone number of the user prefixed with the users country code |


The available time slots can be retrived from the [nearest store api](#catalog), the api result `StoreResponse` contains two varibles `Biz` and `Store`.<br />

Note: The time slots available in the nearest `Store` object represents the time slots set on a store level, if there are no time slot objects in the nearest `Store` object, the the time slots from the `Biz` object which are the time slots configured at Biz level can be used.

#### Step 5:

Verifies the payment transaction, the payment transaction only needs to be verified when the user selected payment option is `paymentGateway`, for other payment options this function can be skipped.

```swift                                                                                                              
    checkoutBuilder.verifyPayment(pid: PAYMENT-ID, completion: COMPLETION-CALLBACK, failure: FAILURE-CALLBACK)
```

PAYMENT-ID: The id returned by the 3rd party payment provider on successfull payment completion.

## Other methods:

```swift   

   // Returns an list of supported payment options, this call returns the supported payment options only when the validateCart function has been called atleast once else it returns an `nil`.
   var paymentOptionsArray = checkoutBuilder.getPaymentModes()
   
```

```swift
   
   // Clears the coupon that has been applied.
   checkoutBuilder.clearCoupon()
   
```
