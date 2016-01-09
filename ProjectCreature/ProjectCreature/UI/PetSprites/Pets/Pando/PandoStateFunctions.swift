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
        
        head.eyes?.hidden = false
        
        breatheNormally()
        
        // prevents eye overlapping if eyes already exist
        guard (head.eyes == nil) else { return }
        
        head.eyes = SKSpriteNode()
        
        if let eyes = head.eyes {
            eyes.position.y = 60
            
            let leftEye = SKSpriteNode(imageNamed: "\(familyName) - EyeNeutral")
            leftEye.position.x = -67
            eyes.addChild(leftEye)
            
            let rightEye = SKSpriteNode(imageNamed: "\(familyName) - EyeNeutral")
            rightEye.position.x = 67
            eyes.addChild(rightEye)
            
            head.addChild(eyes)

            // initially remove any previous blink action 
            eyes.removeActionForKey("blinkAction")
            
            eyes.runAction(action.blink, withKey: "blinkAction")
        }
        
    }
    
    override func happy() {
        
        head.texture = createHeadTexture(forState: .Happy)
        head.eyes?.hidden = true
        breatheNormally()
        
    }
    
    override func sad() {
        
        head.texture = createHeadTexture(forState: .Sad)
        head.eyes?.hidden = true
        breatheNormally()
        
    }
    
    override func asleep() {
        
        head.texture = createHeadTexture(forState: .Asleep)
        breatheNormally()
        
    }
    
    override func fainted() {
        
        head.texture = createHeadTexture(forState: .Fainted)
        head.eyes?.hidden = true
        
        isBreathing = false
        
        // remove all actions and animations
        head.removeAllActions()
        body.removeAllActions()
        leftHand.removeAllActions()
        rightHand.removeAllActions()
        leftLeg.removeAllActions()
        rightLeg.removeAllActions()
        
    }

}


