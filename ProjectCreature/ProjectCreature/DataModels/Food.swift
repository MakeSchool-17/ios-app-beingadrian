//
//  Food.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import RealmSwift


class Food: Object {
    
    // MARK: - Properties
    
    dynamic var name: String = ""
    dynamic var hpValue: Double = 0
    dynamic var textureName: String {
        return name + " - texture"
    }
    
    // MARK: - Creation
    
    static func create(name: String, hpValue: Double) -> Food {
        
        let food = Food()
        food.name = name
        food.hpValue = hpValue
        
        return food
        
    }
    
}