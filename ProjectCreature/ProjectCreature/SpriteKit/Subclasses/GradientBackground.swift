//
//  GradientBackground.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


class GradientBackground: SKSpriteNode {
    
    init(parent: SKScene) {
        
        let texture = SKTexture(imageNamed: "Background")
        super.init(texture: texture, color: UIColor(), size: parent.frame.size)
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
