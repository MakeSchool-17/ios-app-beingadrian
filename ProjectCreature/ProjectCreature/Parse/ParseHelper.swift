//
//  ParseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import PromiseKit


typealias PFBooleanResultAdapter = (Bool, NSError?) -> Void
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
    
    
    // MARK: - Local datastore methods
    
    func saveObjectLocallyAndOnline(object: PFObject) {
        
        firstly {
            object.saveLocallyInBackground()
        }.then { (success) in
            object.saveEventually()
        }

    }
    
    func retrieveUserCreature() -> Promise<PFObject> {
        
        return Promise { (adapter: PFObjectResultAdapter) in
            let query = PFQuery(className: self.CreatureClassName)
            query.fromLocalDatastore()
            
            query.getFirstObjectInBackgroundWithBlock(adapter)
        }
        
    }
    
    func deleteLocalObject(object: PFObject) -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            object.unpinInBackgroundWithBlock(adapter)
        }
        
    }
    
}
