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
    var cash: Variable<Int>
    var id: String
    
    /**
    Initializes the class from scratch.
    */
    init(email: String, username: String, id: String) {
        
        self.email = email
        self.username = username
        self.cash = Variable(0)
        self.id = id
        
        bindToFirebase()
        
    }
    
    /** 
    Initializes the class from a Firebase data model.
    */
    init(id: String, model: UserJsonModel) {
        
        self.email = model.email
        self.username = model.username
        self.cash = Variable(model.cash)
        self.id = id
        
        bindToFirebase()
        
    }
    
    /**
    Binds the `cash` property with its corresponding property on Firebase.
    */
    func bindToFirebase() {
        
        let firebaseRef = firebaseHelper.usersRef.childByAppendingPath(id)
        
        cash
            .subscribeNext { cash in
                firebaseRef
                    .childByAppendingPath("cash")
                    .setValue(cash)
            }
            .addDisposableTo(disposeBag)
        
    }
    
}
