//
//  StatsLayerUI.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


extension StatsLayer {
    
    func setupUI() {
        
        self.anchorPoint = CGPointZero
        self.position = CGPointZero
        self.zPosition = 6
        self.alpha = 0
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        addChild(background)
    
    }
    
    
}