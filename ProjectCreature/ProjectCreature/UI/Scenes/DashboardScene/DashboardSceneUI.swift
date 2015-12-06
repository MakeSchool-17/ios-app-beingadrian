//
//  DashboardSceneSetup.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


extension DashboardScene {
    
    func setupUI() {
        
        background = childNodeWithName("background") as? SKSpriteNode
        background.position = CGPointZero
        
        // MARK: Stats button
        
        statsButton = childNodeWithName("statsButton") as? StatsButton
        statsButton.setHorizontalPosition(15 + statsButton.size.width / 2, fromMargin: .LeftMargin)
        statsButton.setVerticalPosition(15 + statsButton.size.height / 2, fromMargin: .BottomMargin)
        
        // MARK: Menu button
        
        menuButton = childNodeWithName("menuButton") as? MenuButton
        menuButton.setHorizontalPosition(15 + menuButton.size.width / 2, fromMargin: .RightMargin)
        menuButton.setVerticalPosition(15 + menuButton.size.width / 2, fromMargin: .BottomMargin)
        
        // MARK: Dashboard
        
        dashboard = childNodeWithName("dashboard") as? SKSpriteNode
        dashboard.setHorizontalPosition(22, fromMargin: .LeftMargin)
        dashboard.setVerticalPosition(25, fromMargin: .TopMargin)
        
        circleFrame = dashboard.childNodeWithName("circleFrame") as? SKSpriteNode
        circleFrame.position.x = circleFrame.size.width / 2
        circleFrame.position.y =  -(circleFrame.size.height / 2 + 2)
        
        creatureNameLabel = dashboard.childNodeWithName("creatureNameLabel") as? SKLabelNode
        creatureNameLabel.position.x = 83
        creatureNameLabel.position.y = -21
        
        lvLabel = dashboard.childNodeWithName("lvLabel") as? SKLabelNode
        lvLabel.position.x = creatureNameLabel.frame.maxX + 7
        lvLabel.position.y = creatureNameLabel.position.y
        
        creatureLevelLabel = dashboard.childNodeWithName("creatureLevelLabel") as? SKLabelNode
        creatureLevelLabel.position.x = lvLabel.frame.maxX + 1
        creatureLevelLabel.position.y = creatureNameLabel.position.y
        
        // MARK: Health bar
        
        hpBarBack = dashboard.childNodeWithName("hpBarBack") as? SKSpriteNode
        hpBarBack.position.x = 80
        hpBarBack.position.y = -25
        
        let hpBarMask = SKSpriteNode(imageNamed: "Health bar - back")
        hpBarMask.position.x = hpBarBack.size.width / 2
        hpBarMask.position.y = -(hpBarBack.size.height / 2)
        hpBarCrop = SKCropNode()
        hpBarFront = BarHorizontal(imageNamed: "Health bar - front")
        hpBarFront.position.x = hpBarFront.size.width / 2 - hpBarFront.size.width
        hpBarFront.position.y = -(hpBarBack.size.height / 2)
        hpBarCrop.addChild(hpBarFront)
        hpBarCrop.maskNode = hpBarMask
        hpBarBack.addChild(hpBarCrop)
        
        hpLabel = hpBarBack.childNodeWithName("hpLabel") as? SKLabelNode
        hpLabel.position.x = 9
        hpLabel.position.y = -(hpBarBack.size.height - 6)
        
        hpPercentageLabel = hpBarBack.childNodeWithName("hpPercentageLabel") as? SKLabelNode
        hpPercentageLabel.position.x = hpBarBack.size.width - 11
        hpPercentageLabel.position.y = -(hpBarBack.size.height - 8)
        
        // MARK: Exp bar
        
        expBarBack = dashboard.childNodeWithName("expBarBack") as? SKSpriteNode
        expBarBack.position.x = 70
        expBarBack.position.y = -56
        
        let expBarMask = SKSpriteNode(imageNamed: "Exp bar - back")
        expBarMask.position.x = expBarBack.size.width / 2
        expBarMask.position.y = -(expBarBack.size.height / 2)
        expBarCrop = SKCropNode()
        expBarFront = BarHorizontal(imageNamed: "Exp bar - front")
        expBarFront.position.x = expBarFront.size.width / 2 - expBarFront.size.width
        expBarFront.position.y = -(expBarBack.size.height / 2)
        expBarCrop.addChild(expBarFront)
        expBarCrop.maskNode = expBarMask
        expBarBack.addChild(expBarCrop)
        
        expLabel = expBarBack.childNodeWithName("expLabel") as? SKLabelNode
        expLabel.position.x = 19
        expLabel.position.y = -(expBarBack.size.height - 4)
        
        // MARK: Energy
        
        energyGroup = childNodeWithName("energyGroup")
        energyGroup.setHorizontalPosition(.Center)
        energyGroup.setVerticalPosition(35, fromMargin: .BottomMargin)
        energyGroup.position.x -= energyGroup.frame.width / 2
        energyGroup.position.y -= energyGroup.frame.height / 2
        
        energyLabel = energyGroup.childNodeWithName("energyLabel") as? SKLabelNode
        energyLabel.position.x = 0
        energyLabel.position.y = 0
        
        energyIcon = energyGroup.childNodeWithName("energyIcon") as? SKSpriteNode
        energyIcon.position.x = energyLabel.frame.minX - 7
        energyIcon.position.y = 1
        
    }
    
    func readjustLevelLabelXPosition() {

        lvLabel.position.x = creatureNameLabel.frame.maxX + 7
        creatureLevelLabel.position.x = lvLabel.frame.maxX + 1
        
    }
    
}