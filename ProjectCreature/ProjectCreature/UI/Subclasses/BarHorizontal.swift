//
//  BarHorizontal.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/2/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit

class BarHorizontal: SKSpriteNode {
    
    init(imageNamed: String) {

        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor(), size: texture.size())

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Changes bar progress by changing the front bar horizontal position.
        
     - parameter percentage: The progress percentage.
     */
    func changeBarProgress(byPercentage percentage: Double) {
        
        self.position.x = (-self.size.halfWidth) + self.size.width * CGFloat(percentage / 100)
        
    }
    
    
    /**
     Animates the horizontal bar to the designated progress value.
     
     - parameter percentage: The designated progress percentage between 0.0 to 1.0.
     */
    func animateBarProgress(toPercentage percentage: Float) {
        
        let targetPositionX = (-self.size.halfWidth) + self.size.width * CGFloat(percentage)
        
        let action = SKAction.moveToX(targetPositionX, duration: 0.5)
        action.timingMode = .EaseOut
        
        self.runAction(action)
        
    }
    
}
