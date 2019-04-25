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
        guard let startTimeString: String = startTime.currentDateTime?.hhmmaString, let endTimeString: String = endTime.currentDateTime?.hhmmaString else { return "- -" }
        return "\(startTimeString) - \(endTimeString)"
    }

}
