//
//  MenuLayerUI.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


extension MenuLayer {
    
    func setupUI(parent parent: SKNode) {
        
        self.zPosition = 7
        
        menuLine = SKSpriteNode(imageNamed: "Menu line")
        menuLine.position = CGPoint(x: parent.frame.maxX / 2, y: parent.frame.maxY / 2)
        menuLine.zPosition = 8
        self.addChild(menuLine)
        
        trophyIcon = SKSpriteNode(imageNamed: "Trophy icon")
        
    }
    
    
}