//
//  Pet.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/13/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import RxSwift
import Firebase


class Pet: NSObject, NSCoding {
    
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
     * The pet's corresponding sprite. It's not stored on Firebase and 
     * it's dynamically initialized from the Pet's `family` property.
     */
    var sprite: Variable<PetSprite>
    
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
    
    // MARK: - Initialization
    
    /**
     * Initializes the class from scratch.
     */
    init(name: String, family: Family, ownerUID: String) {
        
        self.name = Variable(name)
        self.level = Variable(0)
        self.exp = Variable(0)
        self.expMax = Variable(10)
        self.hp = Variable(0)
        self.hpMax = Variable(10)
        self.family = Variable(family)
        self.ownerUID = Variable(ownerUID)
        self.sprite = Variable(family.sprite)
        
        let id = firebaseHelper.petsRef.childByAutoId().key
        self.id = Variable(id)
        
        super.init()
        
        bindToFirebase()
        
    }
    
    /**
     * Initializes the class from a Firebase JSON data model.
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
        
        super.init()
        
        bindToFirebase()
        
    }
    
    // MARK: - NSCopying
    
    required convenience init?(coder decoder: NSCoder) {
        
        func decodeWithKey(key: String) -> AnyObject? {
            return decoder.decodeObjectForKey(key)
        }
        
        guard
            let nameValue = decodeWithKey("PetNameValue") as? String,
            let levelValue = decodeWithKey("PetLevelValue") as? Int,
            let expValue = decodeWithKey("PetExpValue") as? Float,
            let expMaxValue = decodeWithKey("PetExpMaxValue") as? Float,
            let hpValue = decodeWithKey("PetHpValue") as? Float,
            let hpMaxValue = decodeWithKey("PetHpMaxValue") as? Float,
            let familyRawValue = decodeWithKey("PetFamilyRawValue") as? String,
            let ownerUIDValue = decodeWithKey("PetOwnerUIDValue") as? String,
            let idValue = decodeWithKey("PetIDValue") as? String
        else { return nil }
        
        guard let family = Family(rawValue: familyRawValue) else { return nil }
        
        self.init(name: nameValue, family: family, ownerUID: ownerUIDValue)
        
        self.level.value = levelValue
        print("> Exp value: \(expValue)")
        print("> Exp max value: \(expMaxValue)")
        self.exp.value = expValue
        self.expMax.value = expMaxValue
        
        print("> HP value: \(hpValue)")
        print("> HP max value: \(hpMaxValue)")
        self.hp.value = hpValue
        self.hpMax.value = hpMaxValue
        
        self.id.value = idValue
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.name.value, forKey: "PetNameValue")
        coder.encodeObject(self.level.value, forKey: "PetLevelValue")
        coder.encodeObject(self.exp.value, forKey: "PetExpValue")
        coder.encodeObject(self.expMax.value, forKey: "PetExpMaxValue")
        coder.encodeObject(self.hp.value, forKey: "PetHpValue")
        coder.encodeObject(self.hpMax.value, forKey: "PetHpMaxValue")
        coder.encodeObject(self.family.value.rawValue, forKey: "PetFamilyRawValue")
        coder.encodeObject(self.ownerUID.value, forKey: "PetOwnerUIDValue")
        coder.encodeObject(self.id.value, forKey: "PetIDValue")
        
    }
    
    /**
     * Binds each of `Pet` property to Firebase.
     */
    func bindToFirebase() {
        
        let ref = firebaseHelper.petsRef.childByAppendingPath(id.value)
        
        name
            .asObservable()
            .subscribeNext { name in
                ref.updateChildValues(["name": name])
            }
            .addDisposableTo(disposeBag)
        
        level
            .asObservable()
            .subscribeNext { level in
                ref.updateChildValues(["level": level])
            }
            .addDisposableTo(disposeBag)
        
        exp
            .asObservable()
            .subscribeNext { exp in
                ref.updateChildValues(["exp": exp])
            }
            .addDisposableTo(disposeBag)
        
        expMax
            .asObservable()
            .subscribeNext { expMax in
                ref.updateChildValues(["expMax": expMax])
            }
            .addDisposableTo(disposeBag)
        
        hp
            .asObservable()
            .subscribeNext { hp in
                ref.updateChildValues(["hp": hp])
            }
            .addDisposableTo(disposeBag)
        
        hpMax
            .asObservable()
            .subscribeNext { hpMax in
                ref.updateChildValues(["hpMax": hpMax])
            }
            .addDisposableTo(disposeBag)
        
        family
            .asObservable()
            .subscribeNext { family in
                ref.updateChildValues(["family": family.rawValue])
            }
            .addDisposableTo(disposeBag)
        
        ownerUID
            .asObservable()
            .subscribeNext { ownerUID in
                ref.updateChildValues(["ownerUID": ownerUID])
            }
            .addDisposableTo(disposeBag)
        
    }
    
}