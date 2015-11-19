//
//  CreatureDescription.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import Gloss


enum CreatureType: String {
    case TypeA = "TypeA"
    case TypeB = "TypeB"
    case TypeC = "TypeC"
}

struct CreatureDescription: Glossy {
    
    var type: String?
    var evolutionStage: Int?
    var color: UIColor?
    var sounds: [String]?
    var textures: [String]?
    
    init?(json: JSON) {
        self.type = "type" <~~ json
        self.evolutionStage = "evolutionStage" <~~ json
        self.color = "color" <~~ json
        self.sounds = "sounds" <~~ json
        self.textures = "textures" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "type" ~~> self.type,
            "evolutionStage" ~~> self.evolutionStage,
            "color" ~~> self.color,
            "sounds" ~~> self.sounds,
            "textures" ~~> self.textures
        ])
    }
    
}