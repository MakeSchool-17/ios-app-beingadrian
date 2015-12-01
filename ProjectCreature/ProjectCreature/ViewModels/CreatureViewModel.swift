//
//  CreatureViewModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/30/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


protocol CreatureViewModel {
    
    var name: String { get set }
    var level: Int { get set }
    var exp: Int { get set }
    var happiness: Int { get set }

}