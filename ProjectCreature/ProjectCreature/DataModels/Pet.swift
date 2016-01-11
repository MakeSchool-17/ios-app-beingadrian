//
//  Pet.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import RxSwift
import Firebase


class Pet {
    
    var disposeBag = DisposeBag()
    
    let firebaseHelper = FirebaseHelper()
    
    // MARK: - Properties
    
    var name: Variable<String>
    var level: Variable<Int>
    var exp: Variable<Float>
    var expMax: Variable<Float>
    var hp: Variable<Float>
    var hpMax: Variable<Float>
    var family: Variable<Family>
    var ownerUID: Variable<String>
    var id: Variable<String>
    
    /**
     * The pet's corresponding sprite. It's not stored on Firebase and it's dynamically initialized from the Pet's `family` property.
     */
    var sprite: Variable<PetSprite>
    
    /**layer     * An enum containing all the Pet family types. Each case has a `sprite` property that returns the family's corresponding sprite.
     * Families:
     *  - Dog
     *  - Cat
     *  - Pando
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
    
    // MARK: - Initialization
    
    /**
     * Initializes the class from scratch.
     */
    init(name: String, family: Family, owner: User) {
        
        self.name = Variable(name)
        self.level = Variable(0)
        self.exp = Variable(0)
        self.expMax = Variable(10)
        self.hp = Variable(0)
        self.hpMax = Variable(10)
        self.family = Variable(family)
        self.ownerUID = Variable(owner.uid)
        self.sprite = Variable(family.sprite)
        
        let id = firebaseHelper.petsRef.childByAutoId().key
        self.id = Variable(id)
        
        bindToFirebase()
        
    }
    
    /**
     * Initializes the class from a Firebase data model.
     */
    init(id: String, model: PetJsonModel) {
        
        print("> Initializing Pet from a Firebase data model")
        
        self.name = Variable(model.name)
        self.level = Variable(model.level)
        self.exp = Variable(model.exp)
        self.expMax = Variable(model.expMax)
        self.hp = Variable(model.hp)
        self.hpMax = Variable(model.hpMax)
        self.family = Variable(model.family)
        self.ownerUID = Variable(model.ownerUID)
        self.sprite = Variable(model.family.sprite)
        self.id = Variable(id)
        
    }
    
    /**
     * Binds each of `Pet` property to Firebase.
     */
    func bindToFirebase() {
        
        let ref = firebaseHelper.petsRef.childByAppendingPath(id.value)
        
        name
            .subscribeNext { name in
                ref.updateChildValues(["name": name])
            }
            .addDisposableTo(disposeBag)
        
        level
            .subscribeNext { level in
                ref.updateChildValues(["level": level])
            }
            .addDisposableTo(disposeBag)
        
        exp
            .subscribeNext { exp in
                ref.updateChildValues(["exp": exp])
            }
            .addDisposableTo(disposeBag)
        
        expMax
            .subscribeNext { expMax in
                ref.updateChildValues(["expMax": expMax])
            }
            .addDisposableTo(disposeBag)
        
        hp
            .subscribeNext { hp in
                ref.updateChildValues(["hp": hp])
            }
            .addDisposableTo(disposeBag)
        
        hpMax
            .subscribeNext { hpMax in
                ref.updateChildValues(["hpMax": hpMax])
            }
            .addDisposableTo(disposeBag)
        
        family
            .subscribeNext { family in
                ref.updateChildValues(["family": family.rawValue])
            }
            .addDisposableTo(disposeBag)
        
        ownerUID
            .subscribeNext { ownerUID in
                ref.updateChildValues(["ownerUID": ownerUID])
            }
            .addDisposableTo(disposeBag)
        
    }
    
}