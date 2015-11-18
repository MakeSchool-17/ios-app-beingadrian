//
//  ParseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


typealias RetrieveLocalObjectCallback = (object: PFObject?, error: NSError?) -> Void
typealias DeleteLocalObjectCallback = (success: Bool, error: NSError?) -> Void

class ParseHelper {
    
    // MARK: - Keys
    
    let CreatureClassName = "Creature"
    let CreatureNameKey = "name"
    let CreatureLevelKey = "level"
    let CreatureExpKey = "exp"
    let CreatureHappinessKey = "happiness"
    let CreatureObjectIDKey = "objectId"
    let CreatureOwnerKey = "owner"
    
    
    // MARK: - Local datastore methods
    
    func saveObjectLocallyAndOnline(object: PFObject) {
        
        object.pinInBackgroundWithBlock {
            (success, error) in
            
            print(success)
            
            object.saveEventually {
                (success, error) in
                
                print(success)
            }
        }
        
    }
    
    func retrieveLocalObject(withClassName className: String, completion: RetrieveLocalObjectCallback) {
        
        let query = PFQuery(className: className)
        query.fromLocalDatastore()
        
        query.getFirstObjectInBackgroundWithBlock {
            (object, error) in
            
            completion(object: object, error: error)
        }
        
    }
    
    func deleteLocalObject(object: PFObject, completion: DeleteLocalObjectCallback) {
        
        object.unpinInBackgroundWithBlock {
            (success, error) in
            
            completion(success: success, error: error)
        }
        
    }
    
}