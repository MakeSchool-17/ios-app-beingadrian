//
//  DashboardSceneAnimations.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/7/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


extension DashboardScene {

    // MARK: - Transitions
    
    typealias TransitionCallback = () -> Void
    
    func transitionIn(completion completion: TransitionCallback) {
        
        // set initial position
        dashboard.position.y = self.frame.maxX + 400
        statsButton.position.y = -200
        menuButton.position.y = -200
        energyGroup.position.y = -200
        
        let dashboardAction = createMoveActionSpring(
            finalPositionY: self.frame.maxY - 25)
        let statsButtonAction = createMoveActionSpring(
            finalPositionY: 15 + statsButton.size.halfHeight)
        let menuButtonAction = createMoveActionSpring(
            finalPositionY: 15 + menuButton.size.halfWidth)
        let energyGroupAction = createMoveActionSpring(
            finalPositionY: 35)
        
        let action = SKAction.runBlock {
            self.dashboard.runAction(dashboardAction)
            self.statsButton.runAction(statsButtonAction)
            self.menuButton.runAction(menuButtonAction)
            self.energyGroup.runAction(energyGroupAction)
        }
        
        self.runAction(action, completion: completion)
        
    }
    
    func transitionOut(completion: TransitionCallback) {
        
        let dashboardAction = createMoveActionEaseIn(
            finalPositionY: self.frame.maxY + 150)
        let statsButtonAction = createMoveActionEaseIn(
            finalPositionY: -100)
        let menuButtonAction = createMoveActionEaseIn(
            finalPositionY: -100)
        let energyGroupAction = createMoveActionEaseIn(
            finalPositionY: -100)
        
        let action = SKAction.runBlock {
            self.dashboard.runAction(dashboardAction)
            self.statsButton.runAction(statsButtonAction)
            self.menuButton.runAction(menuButtonAction)
            self.energyGroup.runAction(energyGroupAction)
        }
        
        self.runAction(action, completion: completion)
        
    }
    
    // MARK: - Spring action
    
    func createMoveActionSpring(finalPositionY y: CGFloat) -> SKAction {
        
        let springAction = SKAction.moveToY(y,
            duration: 1.1,
            delay: 0,
            usingSpringWithDamping: 1.5,
            initialSpringVelocity: 0)
        
        return springAction
        
    }
    
    func createMoveActionEaseIn(finalPositionY y: CGFloat) -> SKAction {
        
        let actionEaseIn = SKAction.moveToY(y, duration: 0.3)
        actionEaseIn.timingMode = .EaseIn
        
        return actionEaseIn
        
    }
    
}