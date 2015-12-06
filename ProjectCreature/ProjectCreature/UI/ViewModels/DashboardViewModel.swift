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
import RxCocoa


class DashboardViewModel {
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var creatureName: Variable<String>
    var creatureLevel: Variable<String>
    var creatureExpPercentage: Variable<Double>
    var creatureHpPercentage: Variable<Double>
    var creatureSprite: Variable<SKSpriteNode>
    var cash: Variable<String>
    
    init(creature: Creature) {
        
        func getPercentageFrom(a: Double, dividedBy b: Double) -> Variable<Double> {
            let percentage = round(a / b * 100)
            return Variable(percentage)
        }
        
        self.creatureName = Variable(creature.name)
        self.creatureLevel = Variable(String(creature.level))
        self.creatureExpPercentage = getPercentageFrom(creature.exp, dividedBy: creature.expMax)
        self.creatureHpPercentage = getPercentageFrom(creature.hp, dividedBy: creature.hpMax)
        
        // TODO: Improve cash access code
        let currentUser = PFUser.currentUser()!
        self.cash = Variable(String(currentUser["cash"] as! Int))
        
        // TODO: Finalize imageName code
        let imageName = creature.family + String(creature.evolutionStage)
        self.creatureSprite = Variable(SKSpriteNode(imageNamed: imageName))
        
        // RxObserve
        makeRxObservationFor(creature, andUser: currentUser)
        
    }
    
    func makeRxObservationFor(creature: Creature, andUser currentUser: PFUser) {
        
        creature.rx_observe(String.self, "name")
            .subscribeNext {
                self.creatureName.value = $0!
            }
            .addDisposableTo(disposeBag)
        
        creature.rx_observe(Int.self, "level")
            .subscribeNext {
                self.creatureLevel.value = String($0!)
            }
            .addDisposableTo(disposeBag)
        
        let expObservable = creature.rx_observe(Double.self, "exp")
        let expMaxObservable = creature.rx_observe(Double.self, "expMax")
        
        _ = combineLatest(expObservable, expMaxObservable) {
                round($0! / $1! * 100)
            }
            .subscribeNext {
                self.creatureExpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)
        
        let hpObservable = creature.rx_observe(Double.self, "hp")
        let hpMaxObservable = creature.rx_observe(Double.self, "hpMax")
        
        _ = combineLatest(hpObservable, hpMaxObservable) {
                round($0! / $1! * 100)
            }
            .subscribeNext {
                self.creatureHpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)
        
        // TODO: Creature family observation implementation
        creature.rx_observe(String.self, "family")
            .subscribeNext { family in
                
            }
            .addDisposableTo(disposeBag)
        
        currentUser.rx_observe(Int.self, "cash")
            .subscribeNext {
                self.cash.value = String($0!)
            }
            .addDisposableTo(disposeBag)
        
    }

    
}
