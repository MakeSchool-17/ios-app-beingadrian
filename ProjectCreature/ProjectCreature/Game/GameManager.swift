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

    var disposeBag = DisposeBag()
    
    let statsStore: StatsStore
    
    // MARK: - Properties
    
    var user: User
    var creature: Creature
    
    // MARK: - Initialization

    init(user: User, creature: Creature) {

        self.statsStore = StatsStore()
        
        self.user = user
        self.creature = creature
        
        observe()

    }
    
    private func observe() {
        
        
    }
    
}