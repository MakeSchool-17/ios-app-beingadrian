//
//  StatsButton.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import SpriteKit


class StatsButton: SKSpriteNode {
    
    func navigateToScene(scene: SKScene) {
        
        guard let scene = parent as? SKScene else { return }
        
        let transitionAction = SKAction.runBlock {
            
            guard let view = scene.view else { return }
            let transition = SKTransition.pushWithDirection(.Right, duration: 0.35)
            guard let scene = SKScene(fileNamed: "StatsScene") else { return }
            view.presentScene(scene, transition: transition)
            
        }
        
        self.runAction(transitionAction)
        
    }
    
}

extension StatsButton: NavigationButton {}
