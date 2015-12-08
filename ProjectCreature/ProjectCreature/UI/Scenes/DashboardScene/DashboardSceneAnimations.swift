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
    
    enum Transition {
        case In
        case Out
    }
    
    // MARK: - Transitions
    
    typealias TransitionCallback = () -> Void
    
    func transitionIn(completion completion: TransitionCallback) {
        
        let transition: Transition = .In
        
        let dashboardAction = createTopUIAction(
            forTransition: transition,
            finalPositionY: self.frame.maxY - 25)
        let statsButtonAction = createBottomUIAction(
            forTransition: transition,
            finalPositionY: 15 + statsButton.size.height / 2)
        let menuButtonAction = createBottomUIAction(
            forTransition: transition,
            finalPositionY: 15 + menuButton.size.width / 2)
        let energyGroupAction = createBottomUIAction(
            forTransition: transition,
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
        
        let transition: Transition = .Out
        
        let dashboardAction = createTopUIAction(
            forTransition: transition,
            finalPositionY: self.frame.maxY + 200)
        let statsButtonAction = createBottomUIAction(
            forTransition: transition,
            finalPositionY: -100)
        let menuButtonAction = createBottomUIAction(
            forTransition: transition,
            finalPositionY: -100)
        let energyGroupAction = createBottomUIAction(
            forTransition: transition,
            finalPositionY: -100)
        
        let action = SKAction.runBlock {
            self.dashboard.runAction(dashboardAction)
            self.statsButton.runAction(statsButtonAction)
            self.menuButton.runAction(menuButtonAction)
            self.energyGroup.runAction(energyGroupAction)
        }
        
        self.runAction(action, completion: completion)
        
    }
    
    // MARK: - Actions
    
    func createTopUIAction(forTransition transition: Transition, finalPositionY y: CGFloat) -> SKAction {
        
        let actionDown = SKAction.moveToY(y - 10, duration: 0.3)
        let actionUp = SKAction.moveToY(y, duration: 0.4)
        
        switch transition {
        case .In:
            actionDown.timingMode = .EaseIn
            actionUp.timingMode = .EaseOut
        case .Out:
            actionDown.timingMode = .EaseOut
            actionUp.timingMode = .EaseIn
        }
        
        return SKAction.sequence([actionDown, actionUp])
        
    }
    
    func createBottomUIAction(forTransition transition: Transition, finalPositionY y: CGFloat) -> SKAction {
        
        let actionUp = SKAction.moveToY(y + 10, duration: 0.3)
        let actionDown = SKAction.moveToY(y, duration: 0.4)
        
        switch transition {
        case .In:
            actionUp.timingMode = .EaseIn
            actionDown.timingMode = .EaseOut
        case .Out:
            actionUp.timingMode = .EaseOut
            actionDown.timingMode = .EaseIn
        }
    
        return SKAction.sequence([actionUp, actionDown])
        
    }
    
    
}