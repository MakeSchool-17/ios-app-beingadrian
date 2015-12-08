//
//  GameManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/20/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


class GameManager {
    
    var creature: Variable<Creature>
    
    init(creature: Creature) {
        
        self.creature = Variable(creature)
        
    }
    
}