//
//  Place.swift
//  JiteSai
//
//  Created by Alejandro on 7/11/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import Foundation
import Gloss

class Place: Decodable {
    
    private let id: String
    private let name: String!
    private let location: Location!
    
    // MARK: - Deserialization
    required init?(json: JSON) {
        guard let id: String = "id" <~~ json
            else { return nil }
        
        self.id = id
        self.name = "name" <~~ json
        self.location = "location" <~~ json
    }
}



