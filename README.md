
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
- [User login](#login)
    - [Login](#login)
    - [Social user login](#user-social-login)
- [User registration](#user-registration)
    - [Registration](#registration)
    - [Social user registration](#user-social-registration)
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

**Our current release only supports CocoaPods version 1.1.0+**

UrbanPiper supports `CocoaPods` for easy installation.
To Install, see our **[swift integration guide »](https://UrbanPiper.com/help/reference/swift)**

For iOS, tvOS, macOS, and App Extension integrations:

`pod 'UrbanPiper'`

<a name="carthage"></a>
## Carthage

UrbanPiper also supports `Carthage` to package your dependencies as a framework. Include the following dependency in your Cartfile:

`github "urbanpiper/urbanpipersdk-ios"`

Check out the **[Carthage docs »](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)** for more info. 

<a name="initialization"></a>
# Initialization

Import UrbanPiper into AppDelegate.swift, and initialize UrbanPiper within `application:didFinishLaunchingWithOptions:`
![alt text](http://images.mxpnl.com/docs/2016-07-19%2023:27:03.724972-Screen%20Shot%202016-07-18%20at%207.16.51%20PM.png)

```swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    UrbanPiper.initialize(token: "URBANPIPER_TOKEN")
}
```

You initialize your UrbanPiper instance with the token provided to you on UrbanPiper.com.

<a name="user-login"></a>
## User login
```swift
   Login
```
```swift
   Social user login
```

<a name="user-registration"></a>
## User registration
```swift
   Registration
```
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
