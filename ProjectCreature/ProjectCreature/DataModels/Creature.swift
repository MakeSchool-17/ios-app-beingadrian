//
//  Creature.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import RxSwift
import Firebase


class Creature {
    
    var disposeBag = DisposeBag()
    
    let firebaseHelper = FirebaseHelper()
    
    enum Family: String {
        case Dog = "dog"
        case Cat = "cat"
        case Panda = "panda"
        
        var description: String {
            return ""
        }
    }
    
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
    
    // MARK: - Initialization
    
    init(name: String, family: Family, owner: User) {
        
        self.name = Variable(name)
        self.level = Variable(0)
        self.exp = Variable(0)
        self.expMax = Variable(10)
        self.hp = Variable(0)
        self.hpMax = Variable(10)
        self.family = Variable(family)
        self.ownerUID = Variable(owner.uid)
        
        let id = firebaseHelper.creaturesRef.childByAutoId().key
        self.id = Variable(id)
        
        bindToFirebase()
        
    }
    
    init(id: String, model: CreatureJsonModel) {
        
        print("> Initializing Creature from a Firebase data model")
        
        self.name = Variable(model.name)
        self.level = Variable(model.level)
        self.exp = Variable(model.exp)
        self.expMax = Variable(model.expMax)
        self.hp = Variable(model.hp)
        self.hpMax = Variable(model.hpMax)
        self.family = Variable(model.family)
        self.ownerUID = Variable(model.ownerUID)
        self.id = Variable(id)
        
    }
    
    func bindToFirebase() {
        
        let ref = firebaseHelper.creaturesRef.childByAppendingPath(id.value)
        
        name
            .subscribeNext { name in
                ref.childByAppendingPath("name")
                    .setValue(name)
            }
            .addDisposableTo(disposeBag)
        
        level
            .subscribeNext { level in
                ref.childByAppendingPath("level")
                    .setValue(level)
            }
            .addDisposableTo(disposeBag)
        
        exp
            .subscribeNext { exp in
                ref.childByAppendingPath("exp")
                    .setValue(exp)
            }
            .addDisposableTo(disposeBag)
        
        expMax
            .subscribeNext { expMax in
                ref.childByAppendingPath("expMax")
                    .setValue(expMax)
            }
            .addDisposableTo(disposeBag)
        
        hp
            .subscribeNext { hp in
                ref.childByAppendingPath("hp")
                    .setValue(hp)
            }
            .addDisposableTo(disposeBag)
        
        hpMax
            .subscribeNext { maxHp in
                ref.childByAppendingPath("hpMax")
                    .setValue(maxHp)
            }
            .addDisposableTo(disposeBag)
        
        family
            .subscribeNext { family in
                ref.childByAppendingPath("family")
                    .setValue(family.rawValue)
            }
            .addDisposableTo(disposeBag)
        
        ownerUID
            .subscribeNext { ownerUID in
                ref.childByAppendingPath("ownerUID")
                    .setValue(ownerUID)
            }
            .addDisposableTo(disposeBag)
        
    }
    
}