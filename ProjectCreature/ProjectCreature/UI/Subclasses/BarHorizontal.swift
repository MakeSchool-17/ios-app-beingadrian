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
        Changes bar progress by changing the front bar horizontal position
    */
    func changeBarProgress(byPercentage percentage: Double) {
        
        self.position.x = (-self.size.width / 2) + self.size.width * CGFloat(percentage / 100)
        
    }
    
}