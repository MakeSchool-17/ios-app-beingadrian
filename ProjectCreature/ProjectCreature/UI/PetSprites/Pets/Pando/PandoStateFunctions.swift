//
//  PandoStateFunctions.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


extension PandoSprite {
    
    // MARK: - State functions
    
    override func neutral() {
        
        head.texture = createHeadTexture(forState: .Neutral)
        
        head.eyes = SKSpriteNode()
        
        if let eyes = head.eyes {
            eyes.position.y = 60
            
            let leftEye = SKSpriteNode(imageNamed: "Pando - EyeNeutral")
            leftEye.position.x = -67
            eyes.addChild(leftEye)
            
            let rightEye = SKSpriteNode(imageNamed: "Pando - EyeNeutral")
            rightEye.position.x = 67
            eyes.addChild(rightEye)
            
            head.addChild(eyes)
            eyes.runAction(action.blink)
        }

        head.runAction(action.breatheNormal)
        body.runAction(action.breatheNormal)
        leftHand.runAction(action.handLeftMoveNormal)
        rightHand.runAction(action.handRightMoveNormal)
        
    }
    
    override func happy() {
        
        head.texture = createHeadTexture(forState: .Happy)
        
    }
    
    override func sad() {
        
        head.texture = createHeadTexture(forState: .Sad)
        
    }
    
    override func asleep() {
        
        head.texture = createHeadTexture(forState: .Asleep)
        
    }
    
    override func fainted() {
        
        head.texture = createHeadTexture(forState: .Fainted)
        
    }
    
    // MARK: - Helper functions
    
    func createHeadTexture(forState state: State) -> SKTexture {
        
        return SKTexture(imageNamed: familyName + " - Head" + state.rawValue.capitalizedString)
        
    }
    
}
