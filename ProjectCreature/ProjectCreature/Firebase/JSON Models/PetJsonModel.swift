//
//  PetJsonModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/16/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Gloss


struct PetJsonModel: Glossy {
    
    // MARK: - Properties
    
    var name: String
    var level: Int
    var exp: Float
    var expMax: Float
    var hp: Float
    var hpMax: Float
    var family: Pet.Family
    var ownerUID: String
    
    // MARK: - Initialization
    
    init(pet: Pet) {
        
        self.name = pet.name.value
        self.level = pet.level.value
        self.exp = pet.exp.value
        self.expMax = pet.expMax.value
        self.hp = pet.hp.value
        self.hpMax = pet.hpMax.value
        self.family = pet.family.value
        self.ownerUID = pet.ownerUID.value
        
    }
    
    /**
     * Initializes with a Firebase JSON.
     */
    init?(json: JSON) {
        
        guard let name: String = "name" <~~ json else { return nil }
        guard let level: Int = "level" <~~ json else { return nil }
        guard let exp: Float = "exp" <~~ json else { return nil }
        guard let expMax: Float = "expMax" <~~ json else { return nil }
        guard let hp: Float = "hp" <~~ json else { return nil }
        guard let hpMax: Float = "hpMax" <~~ json else { return nil }
        guard let family: Pet.Family = "family" <~~ json else { return nil }
        guard let ownerUID: String = "ownerUID" <~~ json else { return nil }
        
        self.name = name
        self.level = level
        self.exp = exp
        self.expMax = expMax
        self.hp = hp
        self.hpMax = hpMax
        self.family = family
        self.ownerUID = ownerUID
        
    }
    
    // MARK: - Jsonification
    
    func toJSON() -> JSON? {
        
        return jsonify([
            "name" ~~> self.name,
            "level" ~~> self.level,
            "exp" ~~> self.exp,
            "expMax" ~~> self.expMax,
            "hp" ~~> self.hp,
            "hpMax" ~~> self.hpMax,
            "family" ~~> self.family,
            "ownerUID" ~~> self.ownerUID
        ])
        
    }
    
}
