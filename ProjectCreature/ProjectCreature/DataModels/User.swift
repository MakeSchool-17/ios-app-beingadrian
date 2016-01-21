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


class User: NSObject, NSCoding {
    
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
        
        super.init()
        
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
        
        super.init()
        
        bindToFirebase()
        
    }
    
    // MARK: - NSCopying
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard
            let email = decoder.decodeObjectForKey("UserEmail") as? String,
            let username = decoder.decodeObjectForKey("UserUsername") as? String,
            let chargeValue = decoder.decodeObjectForKey("UserChargeValue") as? Int,
            let uid = decoder.decodeObjectForKey("UserUID") as? String
            else { return nil }
        
        self.init(email: email, username: username, uid: uid)
        
        self.charge.value = chargeValue
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.email, forKey: "UserEmail")
        coder.encodeObject(self.username, forKey: "UserUsername")
        coder.encodeObject(self.charge.value, forKey: "UserChargeValue")
        coder.encodeObject(self.uid, forKey: "UserUID")
        
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
