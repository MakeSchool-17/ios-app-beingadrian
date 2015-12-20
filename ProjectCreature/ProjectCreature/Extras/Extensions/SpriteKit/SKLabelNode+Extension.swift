//
//  SKLabelNode+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/18/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


extension SKLabelNode {

    func animateToValueFromZero(
        value: Float,
        duration: NSTimeInterval,
        rounded: Bool,
        addString additionalString: String = "") {
        
        let countAction = SKAction.customActionWithDuration(duration) {
            (node, elapsedTime) in
            
            let timeFraction = Float(elapsedTime) / Float(duration)
            
            var displayValue = Float(round(value * timeFraction * 10) / 10)
            
            if rounded {
                displayValue = round(displayValue)
            }
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            guard let stringValue = formatter.stringFromNumber(displayValue) else {
                return
            }
            
            self.text  = String(stringValue) + additionalString
        }
        
        countAction.timingMode = .EaseInEaseOut
        
        self.runAction(countAction)
        
    }
    
}