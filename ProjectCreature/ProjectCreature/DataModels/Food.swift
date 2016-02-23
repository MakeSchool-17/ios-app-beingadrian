//
//  Food.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/7/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


class Food: NSObject, NSCoding {
    
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
    
    // MARK: - NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard
            let name = decoder.decodeObjectForKey("FoodName") as? String,
            let hpValue = decoder.decodeObjectForKey("FoodHpValue") as? Double
        else {
            return nil
        }
        
        self.init(name: name, hpValue: hpValue)
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.name, forKey: "FoodName")
        coder.encodeObject(self.hpValue, forKey: "FoodHpValue")
        
    }
    
}