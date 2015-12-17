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
    
    var creatureName: Variable<String>
    var creatureLevel: Variable<String>
    var creatureExpPercentage: Variable<Float>
    var creatureHpPercentage: Variable<Float>
    var creatureSprite: Variable<SKSpriteNode>
    var cash: Variable<String>
    
    init(creature: Creature, user: User) {
        
        func getPercentageFrom(a: Float, dividedBy b: Float) -> Variable<Float> {
            let percentage = round(a / b * 100)
            return Variable(percentage)
        }
        
        self.creatureName = Variable(creature.name.value)
        self.creatureLevel = Variable(String(creature.level.value))
        
        self.creatureExpPercentage = getPercentageFrom(
            creature.exp.value, dividedBy: creature.expMax.value)
        self.creatureHpPercentage = getPercentageFrom(
            creature.hp.value, dividedBy: creature.hpMax.value)
        
        // TODO: Improve cash access code
        let cashString = String(user.cash.value)
        self.cash = Variable(cashString)
        
        // TODO: Finalize imageName code
        let imageName = creature.family.value.description
        self.creatureSprite = Variable(SKSpriteNode(imageNamed: imageName))
        
        // Bind creature and user to model view
        bindCreatureToViewModel(creature)
        
    }
    
    func bindCreatureToViewModel(creature: Creature) {
        
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

        _ = combineLatest(creature.exp, creature.expMax) {
                round($0 / $1 * 100)
            }
            .subscribeNext {
                self.creatureExpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)

        _ = combineLatest(creature.hp, creature.hpMax) {
                round($0 / $1 * 100)
            }
            .subscribeNext {
                self.creatureHpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)

        guard let currentUser = FirebaseHelper.currentUser else { return }
        
        currentUser.cash
            .subscribeNext {
                self.cash.value = String($0)
            }
            .addDisposableTo(disposeBag)
        
    }

}
