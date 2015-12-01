//
//  SKButton.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import Foundation


class SKButton: SKSpriteNode {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let action = SKAction(named: "ButtonTapped") else { return }
        self.runAction(action)
        
    }
    
}
