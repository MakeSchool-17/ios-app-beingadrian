//
//  ParseExtension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/18/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


extension PFObject {

    func rx_pinInBackground() -> Observable<Bool> {
        
        return create { observer in
            self.pinInBackgroundWithBlock {
                (success, error) in
                
                if let error = error {
                    print("Error pinning object: \(error.localizedDescription)")
                    observer.on(.Error(error))
                }
                
                observer.on(.Next(success))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
        
    }
    
    func rx_unpinInBackground() -> Observable<Bool> {
        
        return create { observer in
            self.unpinInBackgroundWithBlock {
                (success, error) in
                
                if let error = error {
                    print("Error unpinning object: \(error.localizedDescription)")
                    observer.on(.Error(error))
                }
                
                observer.on(.Next(success))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
        
    }
    
    func rx_saveEventually() -> Observable<Bool> {
        
        return create { observer in
            self.saveEventually {
                (success, error) in
                
                if let error = error {
                    print("Error saving eventually: \(error.localizedDescription)")
                    observer.on(.Error(error))
                }
                
                observer.on(.Next(success))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
        
    }
    
    func rx_deleteInBackground() -> Observable<Bool> {
        
        return create { observer in
            self.deleteInBackgroundWithBlock {
                (success, error) in
                
                if let error = error {
                    print("Error deleting object in background: \(error.localizedDescription)")
                    observer.on(.Error(error))
                }
                
                observer.on(.Next(success))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
        
    }
    
}

extension PFQuery {
    
    enum PFQueryError: ErrorType {
        case ObjectNotFound
        case DefaultError(NSError)
    }
    
    func rx_getFirstObjectInBackground() -> Observable<PFObject> { 
        
        return create { observer in
            self.getFirstObjectInBackgroundWithBlock {
                (object, error) in
                
                if let error = error {
                    print("Error getting first object in background: \(error)")
                    observer.on(.Error(error))
                }
                
                guard let object = object else {
                    observer.on(.Error(PFQueryError.ObjectNotFound))
                    return
                }
                
                observer.on(.Next(object))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
        
    }
    
}

extension PFUser {
    
    static func rx_logInWithUsernameInBackground(username: String, password: String) -> Observable<PFUser?> {
        
        return create { observer in
            PFUser.logInWithUsernameInBackground(username, password: password) {
                (user, error) in
                
                if let error = error {
                    print("Error logging user in: \(error)")
                    observer.on(.Error(error))
                }
                
                observer.on(.Next(user))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
        
    }
    
}