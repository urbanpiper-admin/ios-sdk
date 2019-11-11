//
//  APIManager+FCM.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum FCMAPI {
    case registerForFCM(token: String)
}

extension FCMAPI: UPAPI {
    var path: String {
        switch self {
        case .registerForFCM:
            return "api/v1/device/fcm/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .registerForFCM:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .registerForFCM:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .registerForFCM:
            return .POST
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case let .registerForFCM(token):
            return ["registration_id": token,
                    "device_id": APIManager.uuidString,
                    "channel": APIManager.channel] as [String: AnyObject]
        }
    }
}
