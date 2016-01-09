//
//  GameManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/20/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift
import SpriteKit


class GameManager {

    private var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    let statsStore: StatsStore
    
    var user: User
    var pet: Pet
    
    private var pettingLimitIsReached = false
    private var lastLimitReachedDate = NSDate()
    var pettingCount = Variable(0)
    
    // MARK: - Initialization

    init(user: User, pet: Pet) {

        self.statsStore = StatsStore()
        
        self.user = user
        self.pet = pet

        makeObservations()
        
    }
    
    private func makeObservations() {
        
        observePetting()
        observePetHappiness()
        
    }
    
    // MARK: - Petting
    
    /**
     * Observes the `pettingCount` to perform petting logic when the pet is being pet.
     */
    private func observePetting() {
        
        pettingCount
            .subscribeNext { count in
                if (count == 3) {
                    // limit is reached
                    self.pettingCount.value = 0
                    self.lastLimitReachedDate = NSDate()
                    self.pettingLimitIsReached = true
                }
            }.addDisposableTo(disposeBag)
        
    }
    
    /** 
     * Checks if the petting limit is reached.
     */
    func checkPettingLimitIsReached() -> Bool {
        
        let delay: NSTimeInterval = 60 * 60
        
        let timeDifference = NSDate().timeIntervalSinceDate(lastLimitReachedDate)
        if (timeDifference > delay && pettingLimitIsReached) {
            pettingLimitIsReached = false
            return pettingLimitIsReached
        }
        
        return pettingLimitIsReached
        
    }
    
    // MARK: - State changes
    
    /**
     * Observes the pet's happiness so that the pet's `state` changes depending on its happiness percentage.
     */
    private func observePetHappiness() {
        
        combineLatest(pet.hp, pet.hpMax) {
            return $0 / $1
        }.subscribeNext { fraction in
            let percentage = fraction * 100
            switch percentage {
            case 0:
                print("> Pet is fainted")
                self.pet.sprite.value.state.value = .Fainted
                break
            case 0..<60:
                print("> Pet is sad")
                self.pet.sprite.value.state.value = .Sad
                break
            case 60...100:
                print("> Pet is neutral")
                self.pet.sprite.value.state.value = .Neutral
                break
            default:
                break
            }
        }.addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Food
    
    func consumeFood(food: Food) {
        
        pet.hp.value += Float(food.hpValue)
        
    }
    
}