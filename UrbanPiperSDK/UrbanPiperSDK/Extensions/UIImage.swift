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
    
    static public var launchImage: UIImage? {
        let allPngImageNames = Bundle.main.paths(forResourcesOfType: "png", inDirectory: nil)
        
        for imageName in allPngImageNames {
            guard imageName.contains("LaunchImage") else { continue }
            
            guard let image = UIImage(named: imageName) else { continue }
            
            // if the image has the same scale AND dimensions as the current device's screen...
            
            if (image.scale == UIScreen.main.scale) && (image.size.equalTo(UIScreen.main.bounds.size)) {
                return image
            }
        }
        
        return nil
    }
    
}
