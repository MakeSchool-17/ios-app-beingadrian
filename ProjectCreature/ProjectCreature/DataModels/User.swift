//
//  User.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift
import Firebase


class User {
    
    var disposeBag = DisposeBag()
    
    let firebaseHelper = FirebaseHelper()
    
    // MARK: - Properties
    
    var email: String
    var username: String
    var charge: Variable<Int>
    var uid: String
    
    /**
     * Initializes the class from scratch.
     */
    init(email: String, username: String, uid: String) {
        
        self.email = email
        self.username = username
        self.charge = Variable(0)
        self.uid = uid
        
        bindToFirebase()
        
    }
    
    /**
     * Initializes the class from a Firebase data model.
     */
    init(uid: String, model: UserJsonModel) {
        
        print("> Initializing User from a Firebase data model")
        
        self.email = model.email
        self.username = model.username
        self.charge = Variable(model.cash)
        self.uid = uid
        
        bindToFirebase()
        
    }
    
    /**
     * Binds the `cash` property with its corresponding property on Firebase.
     */
    func bindToFirebase() {
        
        let ref = firebaseHelper.usersRef.childByAppendingPath(uid)
        
        charge
            .asObservable()
            .subscribeNext { cash in
                ref.updateChildValues(["cash": cash])
            }
            .addDisposableTo(disposeBag)
        
    }
    
}
