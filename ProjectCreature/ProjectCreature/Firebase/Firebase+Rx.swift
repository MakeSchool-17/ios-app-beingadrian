//
//  Firebase+Rx.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import Firebase
import RxSwift


extension Firebase {
    
    // MARK: - User authentication
    
    typealias FirebaseResult = [NSObject: AnyObject]
    
    func rx_createUser(email: String, password: String) -> Observable<FirebaseResult> {
        
        return create { observer in
            
            self.createUser(email, password: password) {
                (error: NSError!, result: [NSObject: AnyObject]!) in
                
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(result)
                    observer.onCompleted()
                }
            }
            
            return NopDisposable.instance
        }
    }
    
    func rx_authUser(email: String, password: String) -> Observable<FAuthData> {
        
        return create { observer in
            
            self.authUser(email, password: password) {
                (error, authData) in
                
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(authData)
                    observer.onCompleted()
                }
            }
        
            return NopDisposable.instance
        }
        
    }

    // MARK: - Sending data
    
    func rx_setValue(value: AnyObject!) -> Observable<Firebase> {
        
        return create { observer in
           
            self.setValue(value) {
                (error, firebaseRef) in
                
                if let error = error {
                    observer.onError(error)
                }
                
                observer.onNext(firebaseRef)
                observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
        
    }
    
    // MARK: - Retrieving data
    
    
    
}

