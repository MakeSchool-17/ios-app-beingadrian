//
//  Pet.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import RxSwift
import Firebase
import RealmSwift


class Pet: Object {
    
    var disposeBag = DisposeBag()
    
    let firebaseHelper = FirebaseHelper()
    
    // MARK: - Properties
    
    dynamic var name: String = ""
    dynamic var level: Int = 0
    dynamic var exp: Float = 0
    dynamic var expMax: Float = 0
    dynamic var hp: Float = 0
    dynamic var hpMax: Float = 0
    dynamic var family: String = ""
    dynamic var ownerUID: String = ""
    dynamic var id: String = ""
    
    /**
     * The pet's corresponding sprite. It's not stored on Firebase and
     * it's dynamically initialized from the Pet's `family` property.
     */
    var sprite: PetSprite = PetSprite()
    
    /**
     * An enum containing all the Pet family types. Each case has a
     * `sprite` property that returns the family's corresponding sprite.
     * Families:
     * - Dog
     * - Cat
     * - Pando
     */
    enum Family: String {
        case Dog = "dog"
        case Cat = "cat"
        case Pando = "pando"

        var sprite: PetSprite {
            switch self {
            case .Dog:      return PandoSprite()
            case .Cat:      return PandoSprite()
            case .Pando:    return PandoSprite()
            }
        }
    }
    
    // MARK: - Creation
    
    static func createFromJSONModel(model: PetJsonModel, id: String) -> Pet? {
        
        let pet = Pet()
        
        pet.name = model.name
        pet.level = model.level
        pet.exp = model.exp
        pet.expMax = model.expMax
        pet.hp = model.hp
        pet.hpMax = model.hpMax
        pet.family = model.family
        pet.ownerUID = model.ownerUID
        
        guard let family = Family(rawValue: model.family) else { return nil }
        pet.sprite = family.sprite
        pet.id = id
        
        pet.bindToFirebase()
        
        return pet
        
    }
    
    // MARK: - Firebase
    
    /**
     * Binds each of `Pet` property to Firebase.
     */
    func bindToFirebase() {

        let ref = firebaseHelper.petsRef.childByAppendingPath(id)

        rx_observe(String.self, "")
            .asObservable()
            .subscribeNext { name in
                guard let name = name else { return }
                ref.updateChildValues(["name": name])
            }
            .addDisposableTo(disposeBag)

        rx_observe(Int.self, "")
            .asObservable()
            .subscribeNext { level in
                guard let level = level else { return }
                ref.updateChildValues(["level": level])
            }
            .addDisposableTo(disposeBag)

        rx_observe(Float.self, "")
            .asObservable()
            .subscribeNext { exp in
                guard let exp = exp else { return }
                ref.updateChildValues(["exp": exp])
            }
            .addDisposableTo(disposeBag)

        rx_observe(Float.self, "")
            .asObservable()
            .subscribeNext { expMax in
                guard let expMax = expMax else { return }
                ref.updateChildValues(["expMax": expMax])
            }
            .addDisposableTo(disposeBag)

        rx_observe(Float.self, "")
            .asObservable()
            .subscribeNext { hp in
                guard let hp = hp else { return }
                ref.updateChildValues(["hp": hp])
            }
            .addDisposableTo(disposeBag)

        rx_observe(Float.self, "")
            .asObservable()
            .subscribeNext { hpMax in
                guard let hpMax = hpMax else { return }
                ref.updateChildValues(["hpMax": hpMax])
            }
            .addDisposableTo(disposeBag)

        rx_observe(String.self, "")
            .asObservable()
            .subscribeNext { family in
                guard let family = family else { return }
                ref.updateChildValues(["family": family])
            }
            .addDisposableTo(disposeBag)

        rx_observe(String.self, "")
            .asObservable()
            .subscribeNext { ownerUID in
                guard let ownerUID = ownerUID else { return }
                ref.updateChildValues(["ownerUID": ownerUID])
            }
            .addDisposableTo(disposeBag)
        
    }
    
}