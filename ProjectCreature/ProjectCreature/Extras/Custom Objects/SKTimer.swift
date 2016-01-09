//
//  SKTimer.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit
import RxSwift

/** 
 * Delegate protocol to allow an SKNode to access the function calls of the timer.
 */
protocol SKTimerDelegate: class {
    
    /**
     * Function called every time one second is passed.
     */
    func secondHasPassed(second: NSTimeInterval)
    
    /**
     * Function called when the timer is reset.
     */
    func timerIsReset()
    
}

/** 
 * A timer class that can count in miliseconds as well as seconds.
 */
class SKTimer: SKNode {
    
    // MARK: - Properties
    
    weak var delegate: SKNode?
    
    var elapsedTime: NSTimeInterval = 0
    var elapsedSeconds: NSTimeInterval = 0 {
        didSet {
            guard let delegate = self.delegate as? SKTimerDelegate else { return }
            delegate.secondHasPassed(elapsedSeconds)
        }
    }
    
    var isTiming = false
    
    // MARK: - Timer methods
    
    /**
     * Start the timer.
     */
    func start() {
        
        isTiming = true
        
        let countToSecondAction = SKAction.customActionWithDuration(1) {
            (_, elapsedTime) in
            
            self.elapsedTime += Double(elapsedTime)
        }
        
        // adds one second every time a second is passed
        let secondHasPassedAction = SKAction.runBlock {
            self.elapsedSeconds += 1
            self.start()
        }
        
        let sequence = SKAction.sequence([countToSecondAction, secondHasPassedAction])
        
        delegate?.runAction(sequence, withKey: "timer")
        
    }
    
    /**
     * Stop the timer and removes any current timing actions.
     */
    func stop() {
        
        isTiming = false
        delegate?.removeActionForKey("timer")
        
    }
    
    func reset() {
        
        stop()
        
        elapsedTime = 0
        elapsedSeconds = 0
        
        guard let delegate = self.delegate as? SKTimerDelegate else { return }
        delegate.timerIsReset()
        
    }
    
}