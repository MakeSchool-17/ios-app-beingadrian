//
//  ParseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import PromiseKit


typealias PFObjectResultAdapter = (PFObject?, NSError?) -> Void

class ParseHelper {
    
    // MARK: - Keys
    
    let CreatureClassName = "Creature"
    let CreatureNameKey = "name"
    let CreatureLevelKey = "level"
    let CreatureExpKey = "exp"
    let CreatureHappinessKey = "happiness"
    let CreatureEvolutionStageKey = "evolutionStage"
    let CreatureObjectIDKey = "objectId"
    let CreatureOwnerKey = "owner"
    let CreatureDescriptionkey = "description"
    
    
    // MARK: - Methods
    
    func retrieveUserCreature() -> Promise<PFObject> {
        
        return Promise { (adapter: PFObjectResultAdapter) in
            let query = PFQuery(className: self.CreatureClassName)
            query.fromLocalDatastore()
            
            guard let currentUser = PFUser.currentUser() else { return }
            query.whereKey(self.CreatureOwnerKey, equalTo: currentUser)
            
            query.getFirstObjectInBackgroundWithBlock(adapter)
        }
        
    }
    
}
