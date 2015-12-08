//
//  PFObject+Rx.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/6/15.
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