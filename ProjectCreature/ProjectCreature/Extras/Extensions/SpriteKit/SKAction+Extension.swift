//
//  SKAction+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/25/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit


extension SKAction {
    
    /**
     * Convenience property that returns the action repeated forever.
     */
    var repeatForever: SKAction {
        return SKAction.repeatActionForever(self)
    }
    
}
