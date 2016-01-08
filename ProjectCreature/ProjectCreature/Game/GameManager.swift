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

    private var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    let statsStore: StatsStore
    
    var user: User
    var pet: Pet
    
    // petting
    private var pettingLimitIsReached = false
    private var lastLimitReachedDate = NSDate()
    var pettingCount = Variable(0)
    
    // MARK: - Initialization

    init(user: User, pet: Pet) {

        self.statsStore = StatsStore()
        
        self.user = user
        self.pet = pet
        
        observePetting()

    }
    
    // MARK: - Petting
    
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
    
    
    func checkPettingLimitIsReached() -> Bool {
        
        let delay: NSTimeInterval = 60 * 60
        
        let timeDifference = NSDate().timeIntervalSinceDate(lastLimitReachedDate)
        if (timeDifference > delay && pettingLimitIsReached) {
            pettingLimitIsReached = false
            return pettingLimitIsReached
        }
        
        return pettingLimitIsReached

    }
    
    // MARK: - Food
    
    func consumeFood(food: Food) {
        
        pet.hp.value += Float(food.hpValue)
        
    }
    
}