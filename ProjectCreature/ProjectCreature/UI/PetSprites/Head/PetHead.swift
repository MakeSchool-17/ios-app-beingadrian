//
//  PetHead.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/26/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import RxSwift


class PetHead: SKSpriteNode {
    
    // MARK: - UI Properties
    
    var eyes: SKSpriteNode?
    
    // MARK: - Properties
    
    private var familyName: String!
    
    /**
     * An observable that emmits every time the pet is being pet.
     */
    var isBeingPet = PublishSubject<Void>()
    
    private var firstTouchLocation: CGPoint?
    private var initialScaleY: CGFloat?
    
    /**
     * A Boolean to store the state whether the touch stops moving or not, used to prevent petting bugs.
     */
    private var touchIsMoving = false {
        didSet {
            guard touchIsMoving else { return }
            resetTouchIsMovingAfterDelay()
        }
    }
    
    private var timer: SKTimer = SKTimer()
    
    var isSmiling = false
    
    // MARK: - Initialization 
    
    init(familyName: String) {
        
        let texture = SKTexture(imageNamed: familyName + " - HeadNeutral")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        
        self.familyName = familyName
        
        self.timer.delegate = self
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("> init(coder:) has not been implemented")
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        // cancel any previous actions
        self.removeActionForKey("springBackAction")
        
        self.firstTouchLocation = touch.locationInNode(self)
        self.initialScaleY = self.yScale

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        guard let firstTouchLocation = self.firstTouchLocation else { return }
        guard let initialScaleY = self.initialScaleY else { return }
        
        let touchLocation = touch.locationInNode(self)
        
        // if the touch goes above the head, recover the head
        if (touchLocation.y > self.frame.height) {
            recover()
        }

        // allow timer only when the touch is moving and when no timer is currently running
        if (touchIsMoving && !timer.isTiming) {
            timer.start()
        }
        
        // allow squeezing only when touch location is below the initial touch location
        guard (touchLocation.y < firstTouchLocation.y) else { return }
        
        touchIsMoving = true
        
        let distance = firstTouchLocation.distanceTo(touchLocation)
        let sensitivity = 200
        let fraction = distance / CGFloat(sensitivity)
        
        squeeze(fraction, initialScale: initialScaleY)
    
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        recover()
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        recover()
        
    }
    
    private func resetTouchIsMovingAfterDelay() {
        
        // remove any initial countdown actions
        self.removeActionForKey("resetTouchIsMoving")
        
        let delay = SKAction.waitForDuration(0.5)
        
        let resetTouchIsMoving = SKAction.runBlock {
            self.touchIsMoving = false
            self.timer.reset()
        }
        
        let sequence = SKAction.sequence([delay, resetTouchIsMoving])
        self.runAction(sequence, withKey: "resetTouchIsMoving")
        
    }
    
    // MARK: - Head animation function

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
    
    func smileTemporarily() {
        
        let initialTexture = self.texture
        
        self.texture = SKTexture(imageNamed: "\(familyName) - HeadHappy")
        
        isSmiling = true
        if let eyes = self.eyes { eyes.hidden = true }
        
        let delayAction = SKAction.waitForDuration(1)
        
        let returnToInitialState = SKAction.runBlock {
            self.texture = initialTexture
            self.isSmiling = false
            if let eyes = self.eyes { eyes.hidden = false }
        }
        
        let sequence = SKAction.sequence([delayAction, returnToInitialState])
        
        self.runAction(sequence)
        
    }
    
    /**
     * Recovers the head to its original size by changing its Y-scale back to `1`.
     */
    private func recover() {
        
        let recoverAction = SKAction.scaleYTo(1, duration: 0.333)
        recoverAction.timingMode = .EaseOut
        
        self.runAction(recoverAction, withKey: "springBackAction")
        
    }
    
}

extension PetHead: SKTimerDelegate {
    
    func secondHasPassed(seconds: NSTimeInterval) {
        
        guard (seconds != 0) else { return }
        isBeingPet.onNext()
        
    }
    
    func timerIsReset() {
        
        
        
    }
    
}
