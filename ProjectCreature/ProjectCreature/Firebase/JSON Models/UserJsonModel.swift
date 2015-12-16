//
//  UserJsonModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import Gloss


struct UserJsonModel: Glossy {
    
    var email: String
    var username: String
    var cash: Int
    
    init(email: String, username: String) {
        
        self.email = email
        self.username = username
        self.cash = 0
        
    }
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        
        guard let email: String = "email" <~~ json else { return nil }
        guard let username: String = "username" <~~ json else { return nil }
        guard let cash: Int = "cash" <~~ json else { return nil }
        
        self.email = email
        self.username = username
        self.cash = cash
        
    }
    
    func toJSON() -> JSON? {
        
        return jsonify([
            "email" ~~> self.email,
            "username" ~~> self.username,
            "cash" ~~> self.cash
        ])
        
    }
    
}