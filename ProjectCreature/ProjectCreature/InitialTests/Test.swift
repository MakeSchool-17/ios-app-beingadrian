//
//  Test.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


class Test {
    
    func createTestPet() -> Pet? {
        
        let json = [
            "name": "Pando",
            "level": 1,
            "exp": 30,
            "expMax": 60,
            "hp": 5,
            "hpMax": 100,
            "family": "pando",
            "ownerUID": "174d86e2-ec1c-462a-89c8-4f4a4146e51c"
        ]
        
        guard let jsonModel = PetJsonModel(json: json) else { return nil }
        
        let testPet = Pet.createFromJSONModel(jsonModel, id: "-K5hF9edT-9NWKyMi-MI")
        
        return testPet
        
    }
    
    func createTestUser() -> User {
        
        let userJsonModel = UserJsonModel(email: "bob@iger.com", username: "bobiger")
        let testUser = User.createFromJSONModel(userJsonModel, uid: "")
        return testUser
        
    }
    
}