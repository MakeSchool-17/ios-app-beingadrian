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
        self.petSprite = Variable(pet.sprite.value)
        
        bindPetToViewModel(pet, currentUser: user)
        
    }
    
    // MARK: - Model binding
    
    private func bindPetToViewModel(pet: Pet, currentUser: User) {
        
        pet.name
            .subscribeNext { name in
                self.petName.value = name
            }
            .addDisposableTo(disposeBag)

        pet.level
            .subscribeNext {
                self.petLevel.value = String($0)
            }
            .addDisposableTo(disposeBag)

        combineLatest(pet.exp, pet.expMax) {
                return round($0 / $1 * 100)
            }
            .subscribeNext { percentage in
                print("> Dashboard view model - exp percentage: \(percentage)")
                self.petExpPercentage.value = percentage
            }.addDisposableTo(disposeBag)
        
        combineLatest(pet.hp, pet.hpMax) {
                return round($0 / $1 * 100)
            }
            .subscribeNext {
                self.petHpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)
        
        pet.sprite
            .subscribeNext { sprite in
                self.petSprite.value = sprite
            }
            .addDisposableTo(disposeBag)
        
        currentUser.charge
            .map { cash in
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
