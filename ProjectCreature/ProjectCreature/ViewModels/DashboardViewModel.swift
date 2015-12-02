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
    
    var creatureName: String { get }
    var creatureLevel: String { get }
    var creatureExp: Int { get }
    var creatureHealthPoints: Int { get }
    var creatureSprite: SKSpriteNode { get }
    var cash: Int { get }
    
}

class DashboardViewModel: DashboardViewModelProtocol {
    
    let creatureName: String
    let creatureLevel: String
    let creatureExp: Int
    let creatureHealthPoints: Int
    let creatureSprite: SKSpriteNode
    let cash: Int
    
    init(creature: Creature) {
        
        self.creatureName = creature.name
        self.creatureLevel = String(creature.level)
        self.creatureExp = creature.exp
        self.creatureHealthPoints = creature.healthPoints
        self.cash = PFUser.currentUser()!["cash"] as! Int
        
        let imageName = creature.family + String(creature.evolutionStage)
        self.creatureSprite = SKSpriteNode(imageNamed: imageName)
        
    }
    
}