//
//  ParseHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


class ParseHelper {
    
    enum DataStoreType {
        case Server
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
    
    func retrieveUserCreatureParseObjectFrom(store: DataStoreType) -> Observable<PFObject> {
        
        let query = PFQuery(className: CreatureClassName)
        
        if (store == .Local) {
            query.fromLocalDatastore()
        }
        
        guard let currentUser = PFUser.currentUser() else {
            return failWith(PFErrorType.NoUserLoggedIn)
        }
        
        query.whereKey(CreatureOwnerKey, equalTo: currentUser)
        
        return deferred {query.rx_getFirstObjectInBackground()}
        
    }
    
    func removeUserCreatureFrom(store: DataStoreType) -> Observable<Bool> {
        
        return retrieveUserCreatureParseObjectFrom(store)
            .flatMap { object -> Observable<Bool> in
                switch store {
                case .Local:
                    return object.rx_unpinInBackground()
                case .Server:
                    return object.rx_deleteInBackground()
                }
            }

    }
    
}
