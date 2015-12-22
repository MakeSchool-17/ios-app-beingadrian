//
//  DashboardViewModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/1/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit
import RxSwift


class DashboardViewModel {
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var creatureName: Variable<String> = Variable("")
    var creatureLevel: Variable<String> = Variable("")
    var creatureExpPercentage: Variable<Float> = Variable(0)
    var creatureHpPercentage: Variable<Float> = Variable(0)
    var creatureSprite: Variable<SKSpriteNode> = Variable(SKSpriteNode())
    var cash: Variable<String> = Variable("")
    
    // MARK: - Initialization
    
    init(creature: Creature, user: User) {
        
        bindCreatureToViewModel(creature, currentUser: user)
        
    }
    
    // MARK: - Model binding
    
    private func bindCreatureToViewModel(creature: Creature, currentUser: User) {
        
        creature.name
            .subscribeNext { name in
                self.creatureName.value = name
            }
            .addDisposableTo(disposeBag)

        creature.level
            .subscribeNext {
                self.creatureLevel.value = String($0)
            }
            .addDisposableTo(disposeBag)

        combineLatest(creature.exp, creature.expMax) {
                round($0 / $1 * 100)
            }
            .subscribeNext {
                self.creatureExpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)

        combineLatest(creature.hp, creature.hpMax) {
                round($0 / $1 * 100)
            }
            .subscribeNext {
                self.creatureHpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)
        
        currentUser.cash
            .subscribeNext {
                self.cash.value = String($0)
            }
            .addDisposableTo(disposeBag)
        
    }

}

extension DashboardViewModel: RxCompliant {}
