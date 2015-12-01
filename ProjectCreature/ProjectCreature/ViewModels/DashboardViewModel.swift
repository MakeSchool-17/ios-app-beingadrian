//
//  DashboardViewModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/1/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit

protocol DashboardViewModelProtocol {
    
    var name: String { get }
    var level: String { get }
    var exp: Int { get }
    var healthPoints: Int { get }
    var creatureSprite: SKSpriteNode { get }
    var cash: Int { get }
    
}

class DashboardViewModel: DashboardViewModelProtocol {
    
    let name: String
    let level: String
    let exp: Int
    let healthPoints: Int
    let creatureSprite: SKSpriteNode
    let cash: Int
    
    init(creature: Creature) {
        
        self.name = creature.name
        self.level = String(creature.level)
        self.exp = creature.exp
        self.healthPoints = creature.happiness
        self.cash = PFUser.currentUser()!["cash"] as! Int
        
        let imageName = creature.family + String(creature.evolutionStage)
        self.creatureSprite = SKSpriteNode(imageNamed: imageName)
        
    }
    
}