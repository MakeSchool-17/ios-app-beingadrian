//
//  ParseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


class ParseHelper {
    
    // MARK: - Keys
    
    let CreatureClassName = "Creature"
    let CreatureNameKey = "name"
    let CreatureLevelKey = "level"
    let CreatureExpKey = "exp"
    let CreatureHappinessKey = "happiness"
    let CreatureObjectIDKey = "objectId"
    let CreatureOwnerKey = "owner"
    
    
    // MARK: - Class methods
    
    func saveObjectLocally(object: PFObject) {
        
        object.pinInBackgroundWithBlock {
            (success, error) in
            
            
        }
        
    }
    
}