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
        
        let testPet = Pet(name: "Pando", family: .Pando)
        
        return testPet
        
    }
    
    func createTestUser() -> User {
        
        let testUser = User(
            email: "tester@test.com",
            username: "tester")
        
        return testUser
        
    }
    
}