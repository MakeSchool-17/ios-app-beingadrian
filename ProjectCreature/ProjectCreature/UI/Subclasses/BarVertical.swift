//
//  BarVertical.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


class BarVertical: SKSpriteNode {

    /**
     Animates the vertical bar to the designated progress value by changing its height.
     
     - parameter percentage: The designated progress percentage between 0.0 to 1.0.
     */
    func animateBarProgress(toPercentage percentage: Float) {
        
        let targetHeight: CGFloat
        if percentage < 1.0 {
            targetHeight = 94 * CGFloat(percentage)
        } else {
            targetHeight = 94
        }
        
        let action = SKAction.resizeToHeight(targetHeight, duration: 0.5)
        action.timingMode = .EaseOut
        
        self.runAction(action)
        
    }
    
}
