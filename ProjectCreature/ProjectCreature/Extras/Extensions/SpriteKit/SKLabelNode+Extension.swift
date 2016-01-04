//
//  SKLabelNode+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/18/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


extension SKLabelNode {

    /**
     * Animates by counting to the value from zero.
     *
     * - parameter value: The value to count to.
     * - parameter duration: The duration of the animation.
     * - parameter rounded: Whether the displayed value will be a whole integer or contains decimal points.
     * - parameter addString: Any additional strings that can be appended to the number string.
     */
    func animateToValue(
        value: Float,
        fromValue initialValue: Float,
        duration: NSTimeInterval,
        rounded: Bool,
        addString additionalString: String = "") {
        
        let countAction = SKAction.customActionWithDuration(duration) {
            (_, elapsedTime) in
            
            let timeFraction = Float(elapsedTime) / Float(duration)
            
            var displayValue = initialValue + Float(round(value * timeFraction * 10) / 10)
            
            var text: String
            
            if rounded {
                displayValue = round(displayValue)
                
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                guard let stringValue = formatter.stringFromNumber(displayValue) else {
                    return
                }
                
                text = stringValue + additionalString
            } else {
                text = String(displayValue) + additionalString
            }
            
            self.text = text
            
        }
        
        countAction.timingMode = .EaseInEaseOut
        
        self.runAction(countAction)
        
    }
    
}