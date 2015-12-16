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
    
    enum Family {
        case Dog
        case Cat
        case Panda
        
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
    var id: Variable<String>
    // TODO: Create Firebase reference
    
    // MARK: - Initializatin
    
    init(name: String, family: Family) {
        
        self.name = Variable(name)
        self.level = Variable(0)
        self.exp = Variable(0)
        self.expMax = Variable(0)
        self.hp = Variable(0)
        self.hpMax = Variable(0)
        self.family = Variable(family)
        self.id = Variable("")
        
        firebaseHelper.createCreature(self)
        
    }
    
    func bindToFirebase() {
        
        name
            .subscribeNext { name in
                
            }
            .addDisposableTo(disposeBag)
    }
    
}