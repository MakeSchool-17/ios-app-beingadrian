//
//  PandoStateFunctions.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


extension PandoModel {
    
    // MARK: - State functions
    
    func neutral() {
        
        head.texture = createHeadTexture(forState: .Neutral)
        
        let eyes = SKSpriteNode()
        eyes.position.y = 60
        
        let leftEye = SKSpriteNode(imageNamed: "Eye-Neutral")
        leftEye.position.x = -67
        eyes.addChild(leftEye)
        
        let rightEye = SKSpriteNode(imageNamed: "Eye-Neutral")
        rightEye.position.x = 67
        eyes.addChild(rightEye)
        
        head.addChild(eyes)
        
        head.runAction(action.breatheNormal)
        eyes.runAction(action.blink)
        body.runAction(action.breatheNormal)
        leftHand.runAction(action.handLeftMoveNormal)
        rightHand.runAction(action.handRightMoveNormal)
        
    }
    
    func happy() {
        
        head.texture = createHeadTexture(forState: .Happy)
        
    }
    
    func sad() {
        
        head.texture = createHeadTexture(forState: .Sad)
        
    }
    
    func asleep() {
        
        head.texture = createHeadTexture(forState: .Asleep)
        
    }
    
    func fainted() {
        
        head.texture = createHeadTexture(forState: .Fainted)
        
    }
    
    // MARK: - Helper functions
    
    private func createHeadTexture(forState state: State) -> SKTexture {
        
        return SKTexture(imageNamed: "Head-" + state.rawValue)
        
    }
    
}
