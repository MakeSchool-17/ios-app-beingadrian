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
    
    // MARK: - Properties
    
    var email: String
    var username: String
    var charge: Variable<Int>
    
    /**
     * Initializes the class from scratch.
     */
    init(email: String, username: String) {
        
        self.email = email
        self.username = username
        self.charge = Variable(0)
        
        super.init()
        
    }
    
    // MARK: - NSCopying
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard
            let email = decoder.decodeObjectForKey("UserEmail") as? String,
            let username = decoder.decodeObjectForKey("UserUsername") as? String,
            let chargeValue = decoder.decodeObjectForKey("UserChargeValue") as? Int
            else { return nil }
        
        self.init(email: email, username: username)
        
        self.charge.value = chargeValue
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.email, forKey: "UserEmail")
        coder.encodeObject(self.username, forKey: "UserUsername")
        coder.encodeObject(self.charge.value, forKey: "UserChargeValue")
        
    }
    
}
