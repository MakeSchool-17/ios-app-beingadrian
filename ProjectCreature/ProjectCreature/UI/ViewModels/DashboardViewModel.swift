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
    
    var petName: Variable<String> = Variable("")
    var petLevel: Variable<String> = Variable("")
    var petExpPercentage: Variable<Float> = Variable(0)
    var petHpPercentage: Variable<Float> = Variable(0)
    var petSprite: Variable<PetSprite>
    var cash: Variable<String> = Variable("")
    
    // MARK: - Initialization
    
    init(pet: Pet, user: User) {
        
        // set initial petSprite
        self.petSprite = Variable(pet.sprite)
        
        bindPetToViewModel(pet, currentUser: user)
        
    }
    
    // MARK: - Model binding
    
    private func bindPetToViewModel(pet: Pet, currentUser: User) {
        
        pet.rx_observe(String.self, "name")
            .asObservable()
            .subscribeNext { name in
                guard let name = name else { return }
                self.petName.value = name
            }
            .addDisposableTo(disposeBag)

        pet.rx_observe(Int.self, "level")
            .asObservable()
            .subscribeNext {
                guard let level = $0 else { return }
                self.petLevel.value = String(level)
            }
            .addDisposableTo(disposeBag)

        let expObservable = pet.rx_observe(Float.self, "exp")
        let expMaxObservable = pet.rx_observe(Float.self, "expMax")
        
        Observable.combineLatest(expObservable, expMaxObservable) {
                (exp: Float?, expMax: Float?) -> Float in
                guard let exp = exp, expMax = expMax else { return 0 }
                return round(exp / expMax * 100)
            }
            .subscribeNext { percentage in
                print("> Dashboard view model - exp percentage: \(percentage)")
                self.petExpPercentage.value = percentage
            }.addDisposableTo(disposeBag)
        
        let hpObservable = pet.rx_observe(Float.self, "hp")
        let hpMaxObservable = pet.rx_observe(Float.self, "hpMax")

        Observable.combineLatest(hpObservable, hpMaxObservable) {
                (hp: Float?, hpMax: Float?) -> Float in
                guard let hp = hp, hpMax = hpMax else { return 0 }
                return round(hp / hpMax * 100)
            }
            .subscribeNext {
                self.petHpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)

        pet.rx_observe(PetSprite.self, "sprite")
            .subscribeNext { sprite in
                guard let sprite = sprite else { return }
                self.petSprite.value = sprite
            }
            .addDisposableTo(disposeBag)

        currentUser.rx_observe(Float.self, "charge")
            .asObservable()
            .map { cash -> String in
                guard let cash = cash else { return "" }
                let formattedNumber = NSNumberFormatter()
                formattedNumber.numberStyle = .DecimalStyle
                guard let cashString = formattedNumber.stringFromNumber(cash) else { return "" }
                return cashString
            }
            .subscribeNext {
                self.cash.value = $0
            }
            .addDisposableTo(disposeBag)
        
    }

}

extension DashboardViewModel: RxCompliant {}
