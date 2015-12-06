//
//  StatsButton.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import SpriteKit


class StatsButton: SKSpriteNode, Button {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        performAction()
        
    }
    
    func performAction() {

        guard let scene = parent as? SKScene else { return }
        
        let scaleUpAction = SKAction.scaleTo(1.1, duration: 0.1)

        let transitionAction = SKAction.runBlock {
            
            guard let view = scene.view else { return }
            let transition = SKTransition.pushWithDirection(.Right, duration: 0.3)
            guard let scene = SKScene(fileNamed: "StatsScene") else { return }
            view.presentScene(scene, transition: transition)
            
        }
        
        let actionSequence = SKAction.sequence([scaleUpAction, transitionAction])
        self.runAction(actionSequence)
        
    }
    
}
