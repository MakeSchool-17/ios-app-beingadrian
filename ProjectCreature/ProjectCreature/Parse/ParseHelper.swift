//
//  ParseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import PromiseKit


class ParseHelper {
    
    private typealias PFObjectResultAdapter = (PFObject?, NSError?) -> Void
    
    enum DataStoreType {
        case Parse
        case Local
    }
    
    enum PFErrorType: ErrorType {
        case NoUserLoggedIn
    }
    
    // MARK: - Keys
    
    let CreatureClassName = "Creature"
    let CreatureNameKey = "name"
    let CreatureLevelKey = "level"
    let CreatureExpKey = "exp"
    let CreatureHappinessKey = "happiness"
    let CreatureEvolutionStageKey = "evolutionStage"
    let CreatureFamilyKey = "type"
    let CreatureOwnerKey = "owner"
    
    
    // MARK: - Methods
    
    func retrieveUserCreatureParseObjectFrom(store: DataStoreType) -> Promise<PFObject>{
        
        let query = PFQuery(className: CreatureClassName)
        
        if store == .Local {
            query.fromLocalDatastore()
        }
        
        guard let currentUser = PFUser.currentUser() else {
            return Promise(error: PFErrorType.NoUserLoggedIn)
        }
        
        query.whereKey(CreatureOwnerKey, equalTo: currentUser)
        
        return query.getFirstObjectInBackgroundWithBlock().then {
            (object) -> PFObject in
            
            return object
        }
        
    }
    
    func removeUserCreatureFrom(store: DataStoreType) -> Promise<Bool> {
        
        return retrieveUserCreatureParseObjectFrom(store).then {
            (object) -> Promise<Bool> in
            
            switch store {
            case .Local:
                return object.unpinInBackgroundWithPromise()
            case .Parse:
                return object.deleteInBackgroundWithPromise()
            }

        }
        
    }

    
}
