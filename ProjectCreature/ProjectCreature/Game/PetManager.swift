//
//  PetManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/21/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


class PetManager: Object {
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var pet: Pet = Pet()
    
    // level-related properties
    var petLeveledUp = PublishSubject<Int>()
    var expDifference: Float = 0
    
    // petting-related properties
    dynamic private var pettingLimitIsReached = false
    dynamic private var lastLimitReachedDate = NSDate()
    dynamic var pettingCount = 0
    
    /**
     * The decrease rate of happiness per hour.
     */
    var hpDecreasePerHour: Float {
        return 0.1 * pet.hpMax
    }
    
    // MARK: - Creation
    
    static func create(pet: Pet) -> PetManager {
        
        let petManager = PetManager()
        petManager.pet = pet
        
        petManager.makeObservations()
        
        return petManager
        
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
        
        pet.rx_observe(Float.self, "exp")
            .asObservable()
            .delaySubscription(0.5, scheduler: MainScheduler.instance)
            .subscribeNext { exp in
                guard let exp = exp else { return }
                let percentage = exp / self.pet.expMax * 100
                
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
        
        pet.level += 1
        
        petLeveledUp.onNext(self.pet.level)
        
    }
    
    /**
     * Resets the pet's `exp` property and sets its `expMax` to the next value.
     *
     * Called after the user exits the didLevelUp pop-up screen.
     */
    func resetPetExp() {
        
        pet.exp = 0
        pet.expMax = 100 // TODO: Replace expMax with next value
        
        // TODO: Set next hp depending on level
        pet.hpMax = 100
        pet.hp = pet.hpMax
        
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
        
        pet.hp -= hpDecrease
        
    }
    
    // MARK: - Petting
    
    /**
    * Observes the `pettingCount` to perform petting logic when the pet is being pet.
    * Petting gives the pet 10 exp points and 5% of HP. A pet can only be petted three
    * times every hour.
    */
    private func observePetting() {
        
        rx_observe(Int.self, "pettingCount")
            .filter { return $0 > 0 }
            .subscribeNext { count in
                guard let count = count else { return }
                guard (count != 4) else {
                    // limit is reached
                    self.pettingCount = 0
                    self.lastLimitReachedDate = NSDate()
                    self.pettingLimitIsReached = true
                    return
                }
                
                let maxHp = Int(self.pet.hpMax)
                let newHpValue = self.pet.hp + 5
                self.pet.hp = newHpValue.clamped(0...maxHp)
                self.pet.exp += 11
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
        
        let hpObservable = pet.rx_observe(Float.self, "hp")
        let hpMaxObservable = pet.rx_observe(Float.self, "hpMax")
        
        Observable.combineLatest(hpObservable, hpMaxObservable) {
            (hp: Float?, hpMax: Float?) -> Float in
            guard let hp = hp else { return 0 }
            guard let hpMax = hpMax else { return 0 }
            return hp / hpMax
            }.subscribeNext { fraction in
                let percentage = fraction * 100
                print("> Pet HP: \(percentage)")
                self.pet.sprite.state.value = self.switchPetState(percentage)
                print("> Pet is \(self.pet.sprite.state.value)")
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
        
        let maxHp = Int(pet.hpMax)
        let newValue = pet.hp + Float(food.hpValue)
        pet.hp = newValue.clamped(0...maxHp)
        
        return Observable.empty()
        
    }
    
}