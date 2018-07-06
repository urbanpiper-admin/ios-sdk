//
//  UIImage.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 12/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension UIImage {
    
    static public var appIcon: UIImage? {
        guard let iconsDictionary: [String:Any] = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
            let primaryIconsDictionary: [String:Any] = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
            let iconFiles: [String] = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon: String = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
    
}
