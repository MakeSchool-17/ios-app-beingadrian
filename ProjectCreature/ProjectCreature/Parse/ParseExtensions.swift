//
//  ParseExtension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/18/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import PromiseKit


extension PFObject {
    
    private typealias PFBooleanResultAdapter = (Bool, NSError?) -> Void

    func pinInBackgroundWithPromise() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.pinInBackgroundWithBlock(adapter)
        }
        
    }
    
    func unpinInBackgroundWithPromise() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.unpinInBackgroundWithBlock(adapter)
        }
        
    }
    
    func saveEventuallyWithPromise() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.saveEventually(adapter)
        }
        
    }
    
    func deleteInBackgroundWithPromise() -> Promise<Bool> {
        
        return Promise { (adapter: PFBooleanResultAdapter) in
            self.deleteInBackgroundWithBlock(adapter)
        }
        
    }
    
}

extension PFQuery {
    
    enum PFQueryError: ErrorType {
        case ObjectNotFound
        case DefaultError(NSError)
    }
    
    func getFirstObjectInBackgroundWithBlock() -> Promise<PFObject> {
        
        return Promise { fulfill, reject in
            self.getFirstObjectInBackgroundWithBlock {
                (object, error) in
                
                if let error = error {
                    reject(PFQueryError.DefaultError(error))
                }
                
                guard let object = object else {
                    reject(PFQueryError.ObjectNotFound)
                    return
                }
                
                fulfill(object)
            }
        }
        
    }
    
}

extension PFUser {
    
    typealias PFUserResultAdapter = (PFUser?, NSError?) -> Void
    
    static func logInWithUsernameInBackground(username: String, password: String) -> Promise<PFUser> {
        
        return Promise { (adapter: PFUserResultAdapter) in
            PFUser.logInWithUsernameInBackground(username, password: password, block: adapter)
        }
        
    }
    
}