//
//  CreatureParse.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/1/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxCocoa


class Creature: PFObject, PFSubclassing {
    
    // MARK: - PFSubclassing
    
    override class func initialize() {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
        
    }
    
    class func parseClassName() -> String {
        
        return "Creature"
        
    }
    
    // MARK: - Parse core properties
    
    @NSManaged var name: String
    @NSManaged var level: Int
    @NSManaged var exp: Double
    @NSManaged var expMax: Double
    @NSManaged var hp: Double
    @NSManaged var hpMax: Double
    @NSManaged var evolutionStage: Int
    @NSManaged var family: String
    @NSManaged var owner: PFUser
    
}

