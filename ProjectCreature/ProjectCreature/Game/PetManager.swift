//
//  PetManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/21/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


class PetManager: NSObject, NSCoding {
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var pet: Pet
    
    // level-related properties
    var petLeveledUp = PublishSubject<Int>()
    var expDifference: Float = 0
    
    // petting-related properties
    private var pettingLimitIsReached = false
    private var lastLimitReachedDate = NSDate()
    private var pettingCount = 0
    var pettingObserver = PublishSubject<Void>()
    
    /**
     * The decrease rate of happiness per hour.
     */
    var hpDecreasePerHour: Float {
        return 0.1 * pet.hpMax.value
    }
    
    // MARK: - Initialization 
    
    init(pet: Pet) {
        
        self.pet = pet
        
        super.init()
        
        makeObservations()
        
    }
    
    // MARK: - NSCoding
    
    required convenience init? (coder decoder: NSCoder) {
        
        guard
            let pet = decoder.decodeObjectForKey("PMPet") as? Pet,
            let pettingLimitIsReached = decoder.decodeObjectForKey("PMPettingLimitIsReached") as? Bool,
            let lastLimitReachedDate = decoder.decodeObjectForKey("PMLastLimitReachedDate") as? NSDate,
            let pettingCountValue = decoder.decodeObjectForKey("PMPettingCountValue") as? Int
        else {
            return nil
        }
        
        self.init(pet: pet)
        
        self.pettingLimitIsReached = pettingLimitIsReached
        self.lastLimitReachedDate = lastLimitReachedDate
        self.pettingCount = pettingCountValue
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
    
        coder.encodeObject(pet, forKey: "PMPet")
        coder.encodeObject(pettingLimitIsReached, forKey: "PMPettingLimitIsReached")
        coder.encodeObject(lastLimitReachedDate, forKey: "PMLastLimitReachedDate")
        coder.encodeObject(pettingCount, forKey: "PMPettingCountValue")
        
    }
    
    // MARK: - Observations
    
    private func makeObservations() {
        
        observePetExp()
        observePetting()
        observePetHappiness()
        
    }
    
    // MARK: - Level and exp methods
    
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
        
        resetPetExp()
        
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
    
    // MARK: - Happiness
    
    /**
     * Decreases the pet's happiness based on the time between the last time the
     * app was closed.
     * 
     * - parameter date: The date in which the app was last closed
     */
    func decreaseHappinessBasedOnDate(date: NSDate) {
        
        let hours = abs(date.timeIntervalSinceNow) / (60 * 60)
        let hpDecrease = hpDecreasePerHour * Float(hours)
        
        print("> Hours: \(hours)")
        print("> HP Decrease: \(hpDecrease)")
        print("> HP: \(pet.hp.value)")
        
        pet.hp.value -= hpDecrease
        
        print("> HP After: \(pet.hp.value)")
        
    }
    
    // MARK: - Petting
    
    /**
    * Observes the `pettingCount` to perform petting logic when the pet is being pet.
    * Petting gives the pet 10 exp points and 5% of HP. A pet can only be petted three
    * times every hour.
    */
    private func observePetting() {
        
        pettingObserver
            .subscribeNext {
                self.pettingCount += 1
                
                guard (self.pettingCount < 4) else {
                    // limit is reached
                    self.pettingCount = 0
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
    
    // MARK: - Pet state changes
    
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
    
    func consumeFood(food: Food) -> Observable<Void> {
        
        let maxHp = Int(pet.hpMax.value)
        let newValue = pet.hp.value + Float(food.hpValue)
        pet.hp.value = newValue.clamped(0...maxHp)
        
        return Observable.just()
        
    }
    
}