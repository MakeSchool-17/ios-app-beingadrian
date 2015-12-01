//
//  DashboardSceneSetup.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


class DashboardSceneUI {
    
    weak var scene: DashboardScene?
    
    init(scene: DashboardScene) {
        
        self.scene = scene
        
        scene.background = scene.childNodeWithName("background") as? SKSpriteNode
        scene.background.position = CGPointZero
        
        scene.statsButton = scene.childNodeWithName("statsButton") as? SKButton
        scene.statsButton.setHorizontalPosition(15 + scene.statsButton.size.width / 2, fromMargin: .LeftMargin)
        scene.statsButton.setVerticalPosition(15 + scene.statsButton.size.height / 2, fromMargin: .BottomMargin)
        
        scene.menuButton = scene.childNodeWithName("menuButton") as? SKButton
        scene.menuButton.setHorizontalPosition(15 + scene.menuButton.size.width / 2, fromMargin: .RightMargin)
        scene.menuButton.setVerticalPosition(15 + scene.menuButton.size.width / 2, fromMargin: .BottomMargin)
        
        scene.dashboard = scene.childNodeWithName("dashboard") as? SKSpriteNode
        scene.dashboard.setHorizontalPosition(22, fromMargin: .LeftMargin)
        scene.dashboard.setVerticalPosition(25, fromMargin: .TopMargin)
        
        scene.circleFrame = scene.dashboard.childNodeWithName("circleFrame") as? SKSpriteNode
        scene.circleFrame.position.x = scene.circleFrame.size.width / 2
        scene.circleFrame.position.y =  -(scene.circleFrame.size.height / 2 + 2)
        
        scene.creatureNameLabel = scene.dashboard.childNodeWithName("creatureNameLabel") as? SKLabelNode
        scene.creatureNameLabel.position.x = 83
        scene.creatureNameLabel.position.y = -21
        
        scene.lvLabel = scene.dashboard.childNodeWithName("lvLabel") as? SKLabelNode
        scene.lvLabel.position.x = scene.creatureNameLabel.frame.maxX + 7
        scene.lvLabel.position.y = scene.creatureNameLabel.position.y
        
        scene.creatureLevelLabel = scene.dashboard.childNodeWithName("creatureLevelLabel") as? SKLabelNode
        scene.creatureLevelLabel.position.x = scene.lvLabel.frame.maxX + 1
        scene.creatureLevelLabel.position.y = scene.creatureNameLabel.position.y
        
        // health bar
        
        scene.healthBarBack = scene.dashboard.childNodeWithName("healthBarBack") as? SKSpriteNode
        scene.healthBarBack.position.x = 80
        scene.healthBarBack.position.y = -25
        
        let healthBarMask = SKSpriteNode(imageNamed: "Health bar - back")
        healthBarMask.position.x = scene.healthBarBack.size.width / 2
        healthBarMask.position.y = -(scene.healthBarBack.size.height / 2)
        scene.healthBarCrop = SKCropNode()
        scene.healthBarFront = SKSpriteNode(imageNamed: "Health bar - front")
        scene.healthBarFront.position.x = scene.healthBarFront.size.width / 2 - scene.healthBarFront.size.width + 20
        scene.healthBarFront.position.y = -(scene.healthBarBack.size.height / 2)
        scene.healthBarCrop.addChild(scene.healthBarFront)
        scene.healthBarCrop.maskNode = healthBarMask
        scene.healthBarBack.addChild(scene.healthBarCrop)
        
        scene.HPLabel = scene.healthBarBack.childNodeWithName("HPLabel") as? SKLabelNode
        scene.HPLabel.position.x = 9
        scene.HPLabel.position.y = -(scene.healthBarBack.size.height - 6)
        
        scene.HPPercentageLabel = scene.healthBarBack.childNodeWithName("HPPercentageLabel") as? SKLabelNode
        scene.HPPercentageLabel.position.x = scene.healthBarBack.size.width - 11
        scene.HPPercentageLabel.position.y = -(scene.healthBarBack.size.height - 8)
        
        // exp bar
        
        scene.expBarBack = scene.dashboard.childNodeWithName("expBarBack") as? SKSpriteNode
        scene.expBarBack.position.x = 70
        scene.expBarBack.position.y = -56
        
        let expBarMask = SKSpriteNode(imageNamed: "Exp bar - back")
        expBarMask.position.x = scene.expBarBack.size.width / 2
        expBarMask.position.y = -(scene.expBarBack.size.height / 2)
        scene.expBarCrop = SKCropNode()
        scene.expBarFront = SKSpriteNode(imageNamed: "Exp bar - front")
        scene.expBarFront.position.x = scene.expBarFront.size.width / 2 - scene.expBarFront.size.width + 30
        scene.expBarFront.position.y = -(scene.expBarBack.size.height / 2)
        scene.expBarCrop.addChild(scene.expBarFront)
        scene.expBarCrop.maskNode = expBarMask
        scene.expBarBack.addChild(scene.expBarCrop)
        
        scene.EXPLabel = scene.expBarBack.childNodeWithName("EXPLabel") as? SKLabelNode
        scene.EXPLabel.position.x = 19
        scene.EXPLabel.position.y = -(scene.expBarBack.size.height - 4)
        
    }
    
}