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
    
    func setupUI() {
        
        self.zPosition = 7
        self.anchorPoint = CGPointZero
        
        func createLabelNode(text: String, posX x: CGFloat, posY y: CGFloat) -> SKLabelNode {
            
            let fontSize: CGFloat = 15
            let fontName = "HelveticaNeue"
            let fontColor = UIColor.rgbaColor(r: 141, g: 142, b: 145, a: 1)
            
            let label = SKLabelNode(text: text)
            label.fontName = fontName
            label.fontSize = fontSize
            label.fontColor = fontColor
            label.position.x = x
            label.position.y = y
            
            return label
            
        }
        
        // MARK: Menu group
        
        menuGroup = SKSpriteNode(imageNamed: "Menu line")
        menuGroup.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        menuGroup.zPosition = 8
        self.addChild(menuGroup)
        
        let menuButtonSize = CGSize(width: 113, height: 113)
        
        // MARK: Trophy
        
        awardsButton = SKButtonSprite()
        awardsButton.size = menuButtonSize
        awardsButton.anchorPoint = CGPoint(x: 1, y: 0)
        awardsButton.position = CGPointZero
        menuGroup.addChild(awardsButton)
        
        awardsIcon = SKSpriteNode(imageNamed: "Trophy icon")
        awardsIcon.position.x = -(26 + awardsIcon.size.halfWidth)
        awardsIcon.position.y = (34 + awardsIcon.size.halfHeight)
        awardsIcon.zPosition = -1
        awardsButton.addChild(awardsIcon)
        
        awardsLabel = createLabelNode("Awards",
            posX: awardsIcon.position.x,
            posY: 15)
        awardsLabel.zPosition = -1
        awardsButton.addChild(awardsLabel)
        
        // MARK: Leaderboard
        
        leaderboardButton = SKButtonSprite()
        leaderboardButton.size = menuButtonSize
        leaderboardButton.anchorPoint = CGPoint(x: 0, y: 0)
        leaderboardButton.position = CGPointZero
        menuGroup.addChild(leaderboardButton)
        
        leaderboardIcon = SKSpriteNode(imageNamed: "Leaderboard icon")
        leaderboardIcon.position.x = 26 + leaderboardIcon.size.halfWidth
        leaderboardIcon.position.y = 34 + leaderboardIcon.size.halfHeight
        leaderboardIcon.zPosition = -1
        leaderboardButton.addChild(leaderboardIcon)
        
        leaderboardLabel = createLabelNode("Leaderboard",
            posX: leaderboardIcon.position.x,
            posY: 15)
        leaderboardLabel.zPosition = -1
        leaderboardButton.addChild(leaderboardLabel)
        
        // MARK: Store
        
        storeButton = SKButtonSprite()
        storeButton.size = menuButtonSize
        storeButton.anchorPoint = CGPoint(x: 1, y: 1)
        storeButton.position = CGPointZero
        menuGroup.addChild(storeButton)
        
        storeIcon = SKSpriteNode(imageNamed: "Store icon")
        storeIcon.position.x = -(26 + storeIcon.size.halfWidth)
        storeIcon.position.y = -(16 + storeIcon.size.halfHeight)
        storeIcon.zPosition = -1
        storeButton.addChild(storeIcon)
        
        storeLabel = createLabelNode("Store",
            posX: storeIcon.position.x,
            posY: storeIcon.frame.minY - 19)
        storeLabel.zPosition = -1
        storeButton.addChild(storeLabel)
        
        // MARK: Settings
        
        settingsButton = SKButtonSprite()
        settingsButton.size = menuButtonSize
        settingsButton.anchorPoint = CGPoint(x: 0, y: 1)
        settingsButton.position = CGPointZero
        menuGroup.addChild(settingsButton)
        
        settingsIcon = SKSpriteNode(imageNamed: "Settings icon")
        settingsIcon.position.x = 26 + settingsIcon.size.halfWidth
        settingsIcon.position.y = -(18 + settingsIcon.size.halfHeight)
        settingsIcon.zPosition = -1
        settingsButton.addChild(settingsIcon)
        
        settingsLabel = createLabelNode("Settings",
            posX: settingsIcon.position.x,
            posY: settingsIcon.frame.minY - 19)
        settingsLabel.zPosition = -1
        settingsButton.addChild(settingsLabel)
        
    }
    
}