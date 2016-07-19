//
//  Location.swift
//  JiteSai
//
//  Created by Alejandro on 7/11/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import Foundation
import SwiftyJSON

class Location {

    internal private(set) var latitude: Double!
    internal private(set) var longitude: Double!
    internal private(set) var name: String!
    internal private(set) var id: String!
    
    required init?(json: JSON) {
        
        if ( json["location"]["lat"] != nil && !json["location"]["lat"].doubleValue.isNaN ) {
            self.latitude = json["location"]["lat"].double!
        } else {
            return nil
        }
        
        if ( json["location"]["lng"] != nil && !json["location"]["lng"].doubleValue.isNaN ) {
            self.longitude = json["location"]["lng"].double!
        } else {
            return nil
        }
        
        if ( json["name"] != nil && !json["name"].stringValue.isEmpty ) {
            self.name = json["name"].string!
        } else {
            return nil
        }
        
        if ( json["id"] != nil && !json["id"].stringValue.isEmpty ) {
            self.id = json["id"].string!
        } else {
            return nil
        }
    }
    
    func _latitude() -> Double {
        return self.latitude
    }
}