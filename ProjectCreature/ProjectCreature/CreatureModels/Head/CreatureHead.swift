//
//  CreatureHead.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/26/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class CreatureHead: SKSpriteNode {
    
    // MARK: - Properties
    
    var pettingCount: Variable<Int> = Variable(0)
    
    private var firstTouchLocation: CGPoint?
    private var initialScaleY: CGFloat?
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        // cancel any previous actions
        self.removeActionForKey("springBackAction")
        
        self.firstTouchLocation = touch.locationInNode(self)
        self.initialScaleY = self.yScale
        
        time()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        guard let firstTouchLocation = self.firstTouchLocation else { return }
        guard let initialScaleY = self.initialScaleY else { return }
        
        let touchLocation = touch.locationInNode(self)
        
        if (touchLocation.y < firstTouchLocation.y) {
            let distance = firstTouchLocation.distanceTo(touchLocation)
            let sensitivity = 200
            let fraction = distance / CGFloat(sensitivity)
            
            squeeze(fraction, initialScale: initialScaleY)
        }
    
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let recoverAction = SKAction.scaleYTo(1, duration: 0.5)
        recoverAction.timingMode = .EaseOut
        
        self.runAction(recoverAction, withKey: "springBackAction")
        
        resetTimer()
        
        // reset petting count
        pettingCount.value = 0
        
    }

    /**
     * Squeezes the head by changing the yScale value using the Sigmoid function.
     *
     * - parameter fraction: The scale fraction.
     * - parameter initialScale: The starting scale (continuing from previous distortions).
     */
    private func squeeze(fraction: CGFloat, initialScale: CGFloat) {
        
        // sigmoid function
        let maxChange: CGFloat = 0.25
        let eExpression = 5 * (fraction - 0.5)
        let bottom = 1 + (1 * pow(CGFloat(M_E), eExpression))
        let scale = maxChange / bottom + (1 - maxChange)
        
        self.yScale = initialScale * scale
        
    }
    
    private func time() {
        
        let delay = SKAction.waitForDuration(1)
        
        let timerAction = SKAction.runBlock {
            self.pettingCount.value++
            self.time()
        }
        
        let actionSequence = SKAction.sequence([delay, timerAction])
        
        self.runAction(actionSequence, withKey: "timerAction")
        
    }
    
    private func resetTimer() {
        
        self.removeActionForKey("timerAction")
        pettingCount.value = 0

    }
    
}
