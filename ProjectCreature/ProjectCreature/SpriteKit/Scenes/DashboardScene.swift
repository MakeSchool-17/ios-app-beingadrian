//
//  DashboardScene.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import SpriteKit
import PromiseKit


class DashboardScene: SKScene {
    
    // MARK: - Properties
    
    var background: SKSpriteNode!
    var statsButton: SKButton!
    
    let healthHelper = HKHelper()
    let parseHelper = ParseHelper()
    
    // MARK: - Base methods
    
    override func didMoveToView(view: SKView) {
        
        background = self.childNodeWithName("Background") as? SKSpriteNode
        background.position = CGPointZero
        
        statsButton = self.childNodeWithName("Stats button") as? SKButton
        statsButton.setHorizontalPosition(15 + statsButton.frame.width / 2, fromMargin: .LeftMargin)
        statsButton.setVerticalPosition(15 + statsButton.frame.height / 2, fromMargin: .BottomMargin)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if statsButton.containsPoint(location) {
            statsButton.touchesBegan(touches, withEvent: event)
        }
        
    }
    
}
