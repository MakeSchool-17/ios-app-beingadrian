//
//  FoodManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/3/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


class FoodManager: NSObject, NSCoding {
    
    enum Error: ErrorType {
        case FoodAlreadyExists
    }
    
    // MARK: - Properties
    
    var currentFood: Variable<Food?>
    
    // MARK: - Initialization
    
    override init() {
        
        self.currentFood = Variable(nil)
        
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        
        let currentFood = decoder.decodeObjectForKey("FMCurrentFood") as? Food
        
        self.init()
        
        self.currentFood = Variable(currentFood)
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.currentFood.value, forKey: "FMCurrentFood")
        
    }
    
    // MARK: - Methods
    
    func didBuyFood(food: Food) -> Observable<Food> {
        
        guard (self.currentFood.value == nil) else {
            return Observable.error(Error.FoodAlreadyExists)
        }
        
        self.currentFood.value = food
        
        return Observable.create { observer in
            
            observer.onNext(food)
            
            return NopDisposable.instance
        }
        
    }
    
}