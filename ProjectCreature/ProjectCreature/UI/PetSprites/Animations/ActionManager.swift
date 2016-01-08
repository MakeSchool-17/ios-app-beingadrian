//
//  ActionManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/25/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


class ActionManager {
    
    // general
    var breatheNormal: SKAction {
        return SKAction(named: "Breathe-Normal")!.repeatForever
    }
    
    // eyes (optional)
    var blink: SKAction {
        let hide = SKAction.fadeAlphaTo(0, duration: 0)
        let show = SKAction.fadeAlphaTo(1, duration: 0)
        let shortDelay = SKAction.waitForDuration(0.25)
        let randomDelay = SKAction.waitForDuration(4, withRange: 7)
        let actionSequence = SKAction.sequence(
            [hide, shortDelay, show, randomDelay])
        return actionSequence.repeatForever
    }
    
    // hands
    var handLeftMoveNormal: SKAction {
        return SKAction(named: "LeftHand-Move-Normal")!.repeatForever
    }
    
    var handRightMoveNormal: SKAction {
        return SKAction(named: "RightHand-Move-Normal")!.repeatForever
    }
    
}
