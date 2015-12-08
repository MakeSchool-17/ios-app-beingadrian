//
//  PFQuery+Rx.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/6/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


extension PFQuery {
    
    public enum PFQueryError: ErrorType {
        case ObjectNotFound
        case DefaultError(NSError)
    }
    
    func rx_getFirstObjectInBackground() -> Observable<PFObject> {
        
        return create { observer in
            self.getFirstObjectInBackgroundWithBlock {
                (object, error) in
                
                if let error = error {
                    print("Error getting first object in background: \(error)")
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