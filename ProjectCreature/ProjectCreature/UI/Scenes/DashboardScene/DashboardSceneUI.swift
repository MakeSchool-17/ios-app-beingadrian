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
        
        let background = SKSpriteNode(imageNamed: "Background")
        self.addChild(background)
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        
        // MARK: Stats button
        
        statsButton = SKButtonSprite(imageNamed: "Stats button")
        self.addChild(statsButton)
        statsButton.setHorizontalPosition(15 + statsButton.size.halfWidth,
            fromMargin: .LeftMargin)
        statsButton.setVerticalPosition(15 + statsButton.size.halfHeight,
            fromMargin: .BottomMargin)
        
        // MARK: Menu button
        
        menuButton = SKButtonSprite(imageNamed: "Menu button")
        self.addChild(menuButton)
        menuButton.setHorizontalPosition(15 + menuButton.size.halfWidth,
            fromMargin: .RightMargin)
        menuButton.setVerticalPosition(15 + menuButton.size.halfHeight,
            fromMargin: .BottomMargin)
        
        // MARK: Dashboard
        
        dashboard = SKSpriteNode()
        self.addChild(dashboard)
        dashboard.anchorPoint = CGPoint(x: 0, y: 1)
        dashboard.setHorizontalPosition(22, fromMargin: .LeftMargin)
        dashboard.setVerticalPosition(25, fromMargin: .TopMargin)
        
        circleFrame = SKSpriteNode(imageNamed: "Circle frame")
        dashboard.addChild(circleFrame)
        circleFrame.position.x = circleFrame.size.halfWidth
        circleFrame.position.y =  -(circleFrame.size.halfHeight + 2)
        
        let greyColor = UIColor.rgbaColor(r: 127, g: 127, b: 127, a: 1)
        
        creatureNameLabel = SKLabelNode(text: "Bob")
        dashboard.addChild(creatureNameLabel)
        creatureNameLabel.fontName = "Avenir-HeavyOblique"
        creatureNameLabel.fontSize = 18
        creatureNameLabel.fontColor = greyColor
        creatureNameLabel.horizontalAlignmentMode = .Left
        creatureNameLabel.position.x = 83
        creatureNameLabel.position.y = -21
        
        lvLabel = SKLabelNode(text: "Lv.")
        creatureNameLabel.addChild(lvLabel)
        lvLabel.fontName = "Avenir-HeavyOblique"
        lvLabel.fontSize = 12
        lvLabel.fontColor = greyColor
        lvLabel.horizontalAlignmentMode = .Left
        lvLabel.position.x = creatureNameLabel.frame.width + 7
        lvLabel.position.y = 0
        
        creatureLevelLabel = SKLabelNode(text: "0")
        lvLabel.addChild(creatureLevelLabel)
        creatureLevelLabel.fontName = "Avenir-HeavyOblique"
        creatureLevelLabel.fontSize = 18
        creatureLevelLabel.fontColor = greyColor
        creatureLevelLabel.horizontalAlignmentMode = .Left
        creatureLevelLabel.position.x = lvLabel.frame.width + 1
        creatureLevelLabel.position.y = 0
        
        // MARK: Health bar
        
        let hpBarBack = SKSpriteNode(imageNamed: "Health bar - back")
        dashboard.addChild(hpBarBack)
        hpBarBack.anchorPoint = CGPoint(x: 0, y: 1)
        hpBarBack.position.x = 80
        hpBarBack.position.y = -25
        
        let hpBarMask = SKSpriteNode(imageNamed: "Health bar - back")
        hpBarMask.position.x = hpBarBack.size.halfWidth
        hpBarMask.position.y = -(hpBarBack.size.halfHeight)
        let hpBarCrop = SKCropNode()
        hpBarFront = BarHorizontal(imageNamed: "Health bar - front")
        hpBarFront.position.x = hpBarFront.size.halfWidth - hpBarFront.size.width
        hpBarFront.position.y = -(hpBarBack.size.halfHeight)
        hpBarCrop.addChild(hpBarFront)
        hpBarCrop.maskNode = hpBarMask
        hpBarBack.addChild(hpBarCrop)
        
        let hpLabel = SKLabelNode(text: "HP")
        hpBarBack.addChild(hpLabel)
        hpLabel.fontName = "Avenir-MediumOblique"
        hpLabel.fontSize = 16
        hpLabel.fontColor = UIColor.whiteColor()
        hpLabel.horizontalAlignmentMode = .Left
        hpLabel.zPosition = 2
        hpLabel.position.x = 9
        hpLabel.position.y = -(hpBarBack.size.height - 6)
        
        hpPercentageLabel = SKLabelNode(text: "0%")
        hpBarBack.addChild(hpPercentageLabel)
        hpPercentageLabel.fontName = "Avenir-MediumOblique"
        hpPercentageLabel.fontSize = 12
        hpPercentageLabel.fontColor = UIColor.whiteColor()
        hpPercentageLabel.horizontalAlignmentMode = .Right
        hpPercentageLabel.zPosition = 2
        hpPercentageLabel.position.x = hpBarBack.size.width - 11
        hpPercentageLabel.position.y = -(hpBarBack.size.height - 8)
        
        // MARK: Exp bar
        
        let expBarBack = SKSpriteNode(imageNamed: "Exp bar - back")
        dashboard.addChild(expBarBack)
        expBarBack.anchorPoint = CGPoint(x: 0, y: 1)
        expBarBack.position.x = 70
        expBarBack.position.y = -56
        
        let expBarMask = SKSpriteNode(imageNamed: "Exp bar - back")
        expBarMask.position.x = expBarBack.size.halfWidth
        expBarMask.position.y = -(expBarBack.size.halfHeight)
        let expBarCrop = SKCropNode()
        expBarFront = BarHorizontal(imageNamed: "Exp bar - front")
        expBarFront.position.x = expBarFront.size.halfWidth - expBarFront.size.width
        expBarFront.position.y = -(expBarBack.size.halfHeight)
        expBarCrop.addChild(expBarFront)
        expBarCrop.maskNode = expBarMask
        expBarBack.addChild(expBarCrop)
        
        expLabel = SKLabelNode(text: "EXP")
        expBarBack.addChild(expLabel)
        expLabel.fontName = "Avenir-MediumOblique"
        expLabel.fontSize = 11
        expLabel.fontColor = UIColor.whiteColor()
        expLabel.horizontalAlignmentMode = .Left
        expLabel.zPosition = 2
        expLabel.position.x = 19
        expLabel.position.y = -(expBarBack.size.height - 4)
        
        // MARK: Energy
        
        energyGroup = SKSpriteNode()
        self.addChild(energyGroup)
        energyGroup.setHorizontalPosition(.Center,
            byValue: -energyGroup.frame.halfWidth)
        energyGroup.setVerticalPosition(35 - energyGroup.frame.halfHeight,
            fromMargin: .BottomMargin)
        
        energyLabel = SKLabelNode(text: "0")
        energyGroup.addChild(energyLabel)
        energyLabel.fontName = "Avenir-Light"
        energyLabel.fontSize = 16
        energyLabel.fontColor = greyColor
        energyLabel.horizontalAlignmentMode = .Center
        energyLabel.verticalAlignmentMode = .Center
        energyLabel.position.x = 0
        energyLabel.position.y = 0
        
        energyIcon = SKSpriteNode(imageNamed: "Energy icon")
        energyGroup.addChild(energyIcon)
        energyIcon.position.x = energyLabel.frame.minX - 7
        energyIcon.position.y = 1
        
    }
    
    func readjustLevelLabelXPosition() {

        lvLabel.position.x = creatureNameLabel.frame.width + 7
        creatureLevelLabel.position.x = lvLabel.frame.width + 1
        
    }
    
}