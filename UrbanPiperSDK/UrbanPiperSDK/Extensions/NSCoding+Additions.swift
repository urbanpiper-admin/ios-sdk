//
//  NSCoding+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 15/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension NSCoding {
    static func registerClassName() {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        NSKeyedArchiver.setClassName(className, for: self)
        NSKeyedUnarchiver.setClass(self, forClassName: className)
    }
    
    static func registerClassNameWhiteLabel() {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        let fullClassName = "WhiteLabel.\(className)"
        NSKeyedUnarchiver.setClass(self, forClassName: fullClassName)
    }
}
