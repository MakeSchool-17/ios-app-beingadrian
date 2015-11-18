//
//  DashboardScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


class DashboardScene: SKScene {
    
    // MARK: - Properties
    
    weak var label: SKLabelNode!
    weak var stepCountLabel: SKLabelNode!
    
    let healthHelper = HKHelper()
    
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        label = self.childNodeWithName("label") as! SKLabelNode
        stepCountLabel = self.childNodeWithName("stepCountLabel") as! SKLabelNode
        
        label.position = CGPoint(x: frame.midX, y: frame.midY + 30)
        stepCountLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        
        try! PFUser.logInWithUsername("beingadrian", password: "test")
        
        let creature = Creature(name: "Bob")
        creature.owner = PFUser.currentUser()
        
        let creatureParseObject = creature.parseObjectFromClass()
        
        creatureParseObject.pinInBackgroundWithBlock {
            (success, error) in
            
            print(success)
            
            creatureParseObject.saveEventually {
                (success, error) in
                
                print(success)
            }
        }
        
    }
    
}
