//
//  PFUser+Rx.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/18/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


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