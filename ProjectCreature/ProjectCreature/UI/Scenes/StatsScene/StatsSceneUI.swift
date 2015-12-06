//
//  StatsSceneUI.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


class StatsSceneUI {
    
    weak var scene: StatsScene?
    
    init(scene: StatsScene) {
        
        self.scene = scene
        
        scene.background = scene.childNodeWithName("background") as? SKSpriteNode
        scene.background.position = CGPointZero
        
        // TODO: Stats scene setup
        
    }


}