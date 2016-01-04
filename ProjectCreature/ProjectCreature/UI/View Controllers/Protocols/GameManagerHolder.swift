//
//  GameManagerHolder.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/4/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


protocol GameManagerHolder: class {
    
    weak var gameManager: GameManager? { get set }
    
}