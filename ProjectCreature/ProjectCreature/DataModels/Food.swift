//
//  Food.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


class Food {
    
    // MARK: - Properties
    
    var name: String
    var hpValue: Double
    var textureName: String {
        return name + " - texture"
    }
    
    // MARK: - Initialization
    
    init(name: String, hpValue: Double) {
        
        self.name = name
        self.hpValue = hpValue
        
    }
    
}