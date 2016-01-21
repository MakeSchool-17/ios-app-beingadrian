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

/**
 * The GameManager class manages the game logic of the application. 
 * Most of its functionality are reactive to changes in the data models
 * e.g. `Pet` and `User` and data changes due to the 
 * user interaction on scene layer.
 */
final class GameManager: NSObject, NSCoding {

    private var disposeBag = DisposeBag()
    
    private let firebase = FirebaseHelper()
    
    // MARK: - Properties
    
    var statsStore: StatsStore
    
    var user: User
    var pet: Pet
    
    // level properties
    var petLeveledUp = PublishSubject<Int>()
    var expDifference: Float = 0
    
    // petting properties
    private var pettingLimitIsReached = false
    private var lastLimitReachedDate = NSDate()
    var pettingCount = Variable(0)
    
    // MARK: - Initialization

    init(user: User, pet: Pet) {

        self.statsStore = StatsStore()
        
        self.user = user
        self.pet = pet

        super.init()
        
        makeObservations()
        
    }
    
    private func makeObservations() {
        
        observePetting()
        observePetHappiness()
        observePetExp()
        
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard
            let statsStore = decoder.decodeObjectForKey("GMStatsStore") as? StatsStore,
            let user = decoder.decodeObjectForKey("GMUser") as? User,
            let pet = decoder.decodeObjectForKey("GMPet") as? Pet,
            let pettingLimitIsReached = decoder.decodeObjectForKey("GMPettingLimitIsReached") as? Bool,
            let lastLimitReachedDate = decoder.decodeObjectForKey("GMLastLimitReachedDate") as? NSDate,
            let pettingCountValue = decoder.decodeObjectForKey("GMPettingCountValue") as? Int
        else {
            return nil
        }
        
        self.init(user: user, pet: pet)
        
        self.statsStore = statsStore
        self.pettingLimitIsReached = pettingLimitIsReached
        self.lastLimitReachedDate = lastLimitReachedDate
        self.pettingCount.value = pettingCountValue
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.statsStore, forKey: "GMStatsStore")
        coder.encodeObject(self.user, forKey: "GMUser")
        coder.encodeObject(self.pet, forKey: "GMPet")
        coder.encodeObject(self.pettingLimitIsReached, forKey: "GMPettingLimitIsReached")
        coder.encodeObject(self.lastLimitReachedDate, forKey: "GMLastLimitReachedDate")
        coder.encodeObject(self.pettingCount.value, forKey: "GMPettingCountValue")
        
    }

    // MARK: - Level and experience points
    
    /** 
     * Observes the pet's exp for any level ups.
     */
    private func observePetExp() {

        pet.exp
            .asObservable()
            .delaySubscription(0.5, scheduler: MainScheduler.instance)
            .subscribeNext { exp in
                
                let percentage = exp / self.pet.expMax.value * 100
                
                if (percentage >= 100) {
                    let difference = percentage - 100
                    self.expDifference = difference
                    print("> Game manager - Exp percentage difference: \(difference)")
                    self.levelUpPet()
                }
                
            }.addDisposableTo(disposeBag)
        
    }
    
    /**
     * Increments the pet's `level` by `1` and emmits the new level value through
     * the `petLeveledUp` subject.
     */
    private func levelUpPet() {

        pet.level.value += 1
        
        petLeveledUp.onNext(self.pet.level.value)
        
    }
    
    /**
     * Resets the pet's `exp` property and sets its `expMax` to the next value.
     * 
     * Called after the user exits the didLevelUp pop-up screen.
     */
    func resetPetExp() {
        
        pet.exp.value = 0
        pet.expMax.value = 100 // TODO: Replace expMax with next value
        
        // TODO: Set next hp depending on level
        pet.hpMax.value = 100
        pet.hp.value = pet.hpMax.value
        
    }
    
    // MARK: - Petting
    
    /**
     * Observes the `pettingCount` to perform petting logic when the pet is being pet.
     * Petting gives the pet 10 exp points and 5% of HP. A pet can only be petted three
     * times every hour.
     */
    private func observePetting() {
        
        pettingCount
            .asObservable()
            .filter { return $0 > 0 }
            .subscribeNext { count in
                
                guard (count != 4) else {
                    // limit is reached
                    self.pettingCount.value = 0
                    self.lastLimitReachedDate = NSDate()
                    self.pettingLimitIsReached = true
                    return
                }

                let maxHp = Int(self.pet.hpMax.value)
                let newHpValue = self.pet.hp.value + 5
                self.pet.hp.value = newHpValue.clamped(0...maxHp)
                self.pet.exp.value += 11
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
     * Observes the pet's happiness so that the pet's `state` changes depending on its
     * happiness percentage.
     */
    private func observePetHappiness() {
        
        Observable.combineLatest(pet.hp.asObservable(), pet.hpMax.asObservable()) {
            return $0 / $1
        }.subscribeNext { fraction in
            let percentage = fraction * 100
            print("> Pet HP: \(percentage)")
            self.pet.sprite.value.state.value = self.switchPetState(percentage)
            print("> Pet is \(self.pet.sprite.value.state.value)")
        }.addDisposableTo(disposeBag)
        
    }
    
    /**
     * Switches the pet's `state` depending on the pet's HP percentage
     */
    private func switchPetState(hpPercentage: Float) -> PetSprite.State {
        
        switch hpPercentage {
        case 0:
            return .Fainted
        case 0..<60:
            return .Sad
        case 60...100:
            return .Neutral
        default:
            break
        }
        
        return .Neutral
        
    }
    
    // MARK: - Food
    
    func consumeFood(food: Food) {
        
        let maxHp = Int(self.pet.hpMax.value)
        let newValue = pet.hp.value + Float(food.hpValue)
        pet.hp.value = newValue.clamped(0...maxHp)
        
    }
    
}