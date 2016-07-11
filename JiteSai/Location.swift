//
//  Location.swift
//  JiteSai
//
//  Created by Alejandro on 7/11/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import Foundation
import Gloss

class Location : Decodable {
    
    private let latitude: NSInteger
    private let longitude: NSInteger
    
    required init?(json: JSON) {
        
        guard let latitude: NSInteger = "latitude" <~~ json
            else { return nil }
        
        guard let longitude: NSInteger = "longitude" <~~ json
            else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
    }
}