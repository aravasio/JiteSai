//
//  User.swift
//  JiteSai
//
//  Created by Alejandro on 7/11/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import Foundation
import Gloss

class User: Decodable {

    private let userId: Int?
    private let password: String?
    
    // MARK: - Deserialization
    required init?(json: JSON) {
        self.userId = "email" <~~ json
        self.password = "password" <~~ json
    }

}