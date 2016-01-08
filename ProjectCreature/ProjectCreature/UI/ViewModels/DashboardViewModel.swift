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
    var petSprite: Variable<PetSprite> = Variable(PandoSprite())
    var cash: Variable<String> = Variable("")
    
    // MARK: - Initialization
    
    init(pet: Pet, user: User) {
        
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
                round($0 / $1 * 100)
            }
            .subscribeNext {
                self.petExpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)

        combineLatest(pet.hp, pet.hpMax) {
                round($0 / $1 * 100)
            }
            .subscribeNext {
                self.petHpPercentage.value = $0
            }
            .addDisposableTo(disposeBag)
        
        pet.family
            .subscribeNext { family in
                self.petSprite.value = family.sprite
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
