//
//  TimeSlot+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 29/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension TimeSlot {
    
    public var displayName: String {
        return "\(startTime.date!.hhmmaString) - \(endTime.date!.hhmmaString)"
    }

}
