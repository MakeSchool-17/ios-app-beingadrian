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
import RealmSwift


class User: Object {
    
    var disposeBag = DisposeBag()
    
    let firebaseHelper = FirebaseHelper()
    
    // MARK: - Properties
    
    dynamic var email: String = ""
    dynamic var username: String = ""
    dynamic var charge: Int = 0
    dynamic var uid: String = ""
    
    // MARK: - Creation
    
    /**
     * Initializes the class from a Firebase data model.
     */
    static func createFromJSONModel(model: UserJsonModel, uid: String) -> User {
        
        print("> Initializing User from a Firebase data model")
        
        let user = User()
        
        user.email = model.email
        user.username = model.username
        user.charge = model.cash
        user.uid = uid
        
        user.bindToFirebase()
        
        return user
        
    }
    
    // MARK: - Firebase
    
    /**
     * Binds the `cash` property with its corresponding property on Firebase.
     */
    func bindToFirebase() {
        
        let ref = firebaseHelper.usersRef.childByAppendingPath(uid)
        
        rx_observe(Int.self, "charge")
            .asObservable()
            .subscribeNext { cash in
                guard let cash = cash else { return }
                ref.updateChildValues(["cash": cash])
            }
            .addDisposableTo(disposeBag)
        
    }
    
}
