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
    
    // MARK: - Properties
    
    var name: Variable<String>
    var level: Variable<Int>
    var exp: Variable<Float>
    var expMax: Variable<Float>
    var hp: Variable<Float>
    var hpMax: Variable<Float>
    var family: Variable<Family>
    
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
    init(name: String, family: Family) {
        
        self.name = Variable(name)
        self.level = Variable(0)
        self.exp = Variable(0)
        self.expMax = Variable(10)
        self.hp = Variable(0)
        self.hpMax = Variable(10)
        self.family = Variable(family)
        self.sprite = Variable(family.sprite)
        
        super.init()
        
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
            let familyRawValue = decodeWithKey("PetFamilyRawValue") as? String
        else { return nil }
        
        guard let family = Family(rawValue: familyRawValue) else { return nil }
        
        self.init(name: nameValue, family: family)
        
        self.level.value = levelValue
        self.exp.value = expValue
        self.expMax.value = expMaxValue
        self.hp.value = hpValue
        self.hpMax.value = hpMaxValue
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.name.value, forKey: "PetNameValue")
        coder.encodeObject(self.level.value, forKey: "PetLevelValue")
        coder.encodeObject(self.exp.value, forKey: "PetExpValue")
        coder.encodeObject(self.expMax.value, forKey: "PetExpMaxValue")
        coder.encodeObject(self.hp.value, forKey: "PetHpValue")
        coder.encodeObject(self.hpMax.value, forKey: "PetHpMaxValue")
        coder.encodeObject(self.family.value.rawValue, forKey: "PetFamilyRawValue")
        
    }
    
}