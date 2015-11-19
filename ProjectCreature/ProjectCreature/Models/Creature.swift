//
//  Creature.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation




class Creature {
    
    private let parseHelper = ParseHelper()
    
    // MARK: - Properties
    
    var name: String
    var level: Int
    var exp: Int
    var happiness: Int
    var evolutionStage: Int
    var type: String
    var objectID: String?
    var owner: PFUser?
    
    enum Family: String {
        case Seal = "seal"
        case Panda = "panda"
        case Dog = "dog"
    }
    
    
    // MARK: - Base methods
    
    init(name: String, type: String) {
        
        self.name = name
        self.level = 0
        self.exp = 0
        self.happiness = 0
        self.evolutionStage = 0
        self.type = type
        
    }
    
    init?(parseObject: PFObject) {
        
        self.name = parseObject[parseHelper.CreatureNameKey] as! String
        self.level = parseObject[parseHelper.CreatureLevelKey] as! Int
        self.exp = parseObject[parseHelper.CreatureExpKey] as! Int
        self.happiness = parseObject[parseHelper.CreatureHappinessKey] as! Int
        self.evolutionStage = parseObject[parseHelper.CreatureEvolutionStageKey] as! Int
        self.type = parseObject[parseHelper.CreatureFamilyKey] as! String
        self.owner = parseObject[parseHelper.CreatureOwnerKey] as? PFUser
        self.objectID = parseObject.objectId!
        
    }
    
    func parseObject() -> PFObject {
        
        let creatureParseObject = PFObject(className: parseHelper.CreatureClassName)
        
        creatureParseObject[parseHelper.CreatureNameKey] = self.name
        creatureParseObject[parseHelper.CreatureLevelKey] = self.level
        creatureParseObject[parseHelper.CreatureExpKey] = self.exp
        creatureParseObject[parseHelper.CreatureHappinessKey] = self.happiness
        creatureParseObject[parseHelper.CreatureEvolutionStageKey] = self.evolutionStage
        creatureParseObject[parseHelper.CreatureFamilyKey] = self.type
        creatureParseObject[parseHelper.CreatureOwnerKey] = self.owner
        
        return creatureParseObject
        
    }
    
}