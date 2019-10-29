//
//  NSCoding+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 15/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension NSCoding {
    static func registerClass(name: String? = nil) {
        let fullClassName: String = name ?? NSStringFromClass(self)
        let className: String = fullClassName.components(separatedBy: ".").last!
        NSKeyedArchiver.setClassName(className, for: self)
        NSKeyedUnarchiver.setClass(self, forClassName: className)

        registerClassNameWhiteLabel(name: name)
        registerClassNameUrbanPiperSDK(name: name)
        registerClassNameUrbanPiper(name: name)
    }

    private static func registerClassNameWhiteLabel(name: String? = nil) {
        let className: String = name ?? NSStringFromClass(self).components(separatedBy: ".").last!
        let fullClassName: String = "WhiteLabel.\(className)"
        NSKeyedUnarchiver.setClass(self, forClassName: fullClassName)
    }

    private static func registerClassNameUrbanPiperSDK(name: String? = nil) {
        let className: String = name ?? NSStringFromClass(self).components(separatedBy: ".").last!
        let fullClassName: String = "UrbanPiperSDK.\(className)"
        NSKeyedUnarchiver.setClass(self, forClassName: fullClassName)
    }

    private static func registerClassNameUrbanPiper(name: String? = nil) {
        let className: String = name ?? NSStringFromClass(self).components(separatedBy: ".").last!
        let fullClassName: String = "UrbanPiper.\(className)"
        NSKeyedUnarchiver.setClass(self, forClassName: fullClassName)
    }
}
