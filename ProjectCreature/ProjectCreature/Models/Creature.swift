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
    var objectID: String?
    var owner: PFUser?
    
    
    // MARK: - Base methods
    
    init(name: String) {
        
        self.name = name
        self.level = 0
        self.exp = 0
        self.happiness = 0
        
    }
    
    init?(parseObject: PFObject) {
        
        self.name = parseObject[parseHelper.CreatureNameKey] as! String
        self.level = parseObject[parseHelper.CreatureLevelKey] as! Int
        self.exp = parseObject[parseHelper.CreatureExpKey] as! Int
        self.happiness = parseObject[parseHelper.CreatureHappinessKey] as! Int
        self.objectID = parseObject.objectId!
        self.owner = parseObject[parseHelper.CreatureOwnerKey] as? PFUser
        
    }
    
    func parseObjectFromClass() -> PFObject {
        
        let creatureParseObject = PFObject(className: parseHelper.CreatureClassName)
        
        creatureParseObject[parseHelper.CreatureNameKey] = self.name
        creatureParseObject[parseHelper.CreatureLevelKey] = self.level
        creatureParseObject[parseHelper.CreatureExpKey] = self.exp
        creatureParseObject[parseHelper.CreatureHappinessKey] = self.happiness
        creatureParseObject[parseHelper.CreatureOwnerKey] = self.owner
        
        return creatureParseObject
        
    }
    
    deinit {
        
        
        
    }
    
}