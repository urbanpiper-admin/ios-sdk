//
//  JSONDecodable.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 07/09/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

protocol JSONDecodable: Codable {
    init(data: Data) throws
}
