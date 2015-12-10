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
        self.anchorPoint = CGPointZero
        
        func createLabelNode(text: String, posX x: CGFloat, posY y: CGFloat) -> SKLabelNode {
            
            let fontSize: CGFloat = 15
            let fontName = "HelveticaNeue"
            let fontColor = UIColor(red: 141/255, green: 142/255, blue: 145/255, alpha: 1)
            
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
        menuGroup.position = CGPoint(x: parent.frame.maxX / 2, y: parent.frame.maxY / 2)
        menuGroup.zPosition = 8
        self.addChild(menuGroup)
        
        // MARK: Trophy icon
        
        trophyIcon = SKSpriteNode(imageNamed: "Trophy icon")
        trophyIcon.position.x = -(26 + trophyIcon.size.width / 2)
        trophyIcon.position.y = (34 + trophyIcon.size.height / 2)
        menuGroup.addChild(trophyIcon)
        
        awardsLabel = createLabelNode("Awards",
            posX: trophyIcon.position.x,
            posY: 15)
        menuGroup.addChild(awardsLabel)
        
        // MARK: Leaderboard icon
        
        leaderboardIcon = SKSpriteNode(imageNamed: "Leaderboard icon")
        leaderboardIcon.position.x = 26 + leaderboardIcon.size.width / 2
        leaderboardIcon.position.y = 34 + leaderboardIcon.size.height / 2
        menuGroup.addChild(leaderboardIcon)
        
        leaderboardLabel = createLabelNode("Leaderboard",
            posX: leaderboardIcon.position.x,
            posY: 15)
        menuGroup.addChild(leaderboardLabel)
        
        // MARK: Store icon
        
        storeIcon = SKSpriteNode(imageNamed: "Store icon")
        storeIcon.position.x = -(26 + storeIcon.size.width / 2)
        storeIcon.position.y = -(16 + storeIcon.size.height / 2)
        menuGroup.addChild(storeIcon)
        
        storeLabel = createLabelNode("Store",
            posX: storeIcon.position.x,
            posY: storeIcon.frame.minY - 19)
        menuGroup.addChild(storeLabel)
        
        // MARK: Settings icon
        
        settingsIcon = SKSpriteNode(imageNamed: "Settings icon")
        settingsIcon.position.x = 26 + settingsIcon.size.width / 2
        settingsIcon.position.y = -(18 + settingsIcon.size.height / 2)
        menuGroup.addChild(settingsIcon)
        
        settingsLabel = createLabelNode("Settings",
            posX: settingsIcon.position.x,
            posY: settingsIcon.frame.minY - 19)
        menuGroup.addChild(settingsLabel)
        
    }
    
}