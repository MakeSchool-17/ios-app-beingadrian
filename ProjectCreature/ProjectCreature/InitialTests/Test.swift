//
//  Test.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


class Test {
    
    func createTestCreature() -> Creature? {
        
        let json = [
            "name": "TestCreature",
            "level": 1,
            "exp": 30,
            "expMax": 60,
            "hp": 60,
            "hpMax": 100,
            "family": "cat",
            "ownerUID": "174d86e2-ec1c-462a-89c8-4f4a4146e51c"
        ]
        
        guard let jsonModel = CreatureJsonModel(json: json) else { return nil }
        
        let testCreature = Creature(id: "-K5hF9edT-9NWKyMi-MI", model: jsonModel)
        
        return testCreature
    }
    
    func createTestUser() -> User {
        
        let testUser = User(email: "test@test.com", username: "tester", uid: "174d86e2-ec1c-462a-89c8-4f4a4146e51c")
        return testUser
        
    }
    
    func simulate(scene: DashboardScene) {
        
        guard let testCreature = createTestCreature() else { return }
        let testUser = createTestUser()
        
        FirebaseHelper.currentUser = testUser
        
        guard let currentTestUser = FirebaseHelper.currentUser else { return }
        
        scene.gameManager = GameManager(creature: testCreature)
        scene.viewModel = DashboardViewModel(creature: testCreature, user: currentTestUser)
        
        scene.bindUI()
        
    }
    
}