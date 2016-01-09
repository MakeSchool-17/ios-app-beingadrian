//
//  HistogramPointer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


class HistogramPointer: SKSpriteNode {

    /**
     * Animates the pointer to a given bar.
     */
    func animateToBar(bar: SKSpriteNode) {
        
        let barMidPosition = bar.position.x + bar.size.halfWidth
        
        let duration: NSTimeInterval = 1.0
        
        let moveAction = SKAction.moveToX(barMidPosition, duration: duration)
        
        func cubicEaseOut(t: Float) -> Float {
            return 1 - pow(1 - t / Float(duration), 5)
        }
        
        moveAction.timingFunction = cubicEaseOut
        
        self.runAction(moveAction)
        
    }
    
}
