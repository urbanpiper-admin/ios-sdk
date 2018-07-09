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
        let fullClassName: String = NSStringFromClass(self)
        let className: String = fullClassName.components(separatedBy: ".").last!
        NSKeyedArchiver.setClassName(className, for: self)
        NSKeyedUnarchiver.setClass(self, forClassName: className)
    }
    
    static func registerClassNameWhiteLabel() {
        let className: String = NSStringFromClass(self).components(separatedBy: ".").last!
        let fullClassName: String = "WhiteLabel.\(className)"
        NSKeyedUnarchiver.setClass(self, forClassName: fullClassName)
    }
}
