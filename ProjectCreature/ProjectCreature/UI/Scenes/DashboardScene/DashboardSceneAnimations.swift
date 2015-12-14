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
        dashboard.position.y = self.frame.maxY + 70
        statsButton.position.y = -200
        menuButton.position.y = -200
        energyGroup.position.y = -200
        
        let dashboardAction = createMoveActionCustomEaseOut(
            finalPositionY: self.frame.maxY - 25)
        let statsButtonAction = createMoveActionCustomEaseOut(
            finalPositionY: 15 + statsButton.size.halfHeight)
        let menuButtonAction = createMoveActionCustomEaseOut(
            finalPositionY: 15 + menuButton.size.halfWidth)
        let energyGroupAction = createMoveActionCustomEaseOut(
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
    
    func createMoveActionCustomEaseOut(finalPositionY y: CGFloat) -> SKAction {
        
        let duration: Double = 0.7
        let actionEaseOut = SKAction.moveToY(y, duration: duration)
        
        func cubicEaseOut(t: Float) -> Float {
            return 1 - pow(1 - t / Float(duration), 5)
        }
        
        actionEaseOut.timingFunction = cubicEaseOut
        
        return actionEaseOut
        
    }
    
    func createMoveActionEaseIn(finalPositionY y: CGFloat) -> SKAction {
        
        let actionEaseIn = SKAction.moveToY(y, duration: 0.3)
        actionEaseIn.timingMode = .EaseIn
        
        return actionEaseIn
        
    }
    
}