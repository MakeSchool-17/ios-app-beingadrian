//
//  FoodManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/3/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


class FoodManager: Object {
    
    enum Error: ErrorType {
        case FoodAlreadyExists
    }
    
    // MARK: - Properties
    
    dynamic var currentFood: Food?

    
    // MARK: - Methods
    
    func didBuyFood(food: Food) -> Observable<Food> {
        
        guard (self.currentFood == nil) else {
            return Observable.error(Error.FoodAlreadyExists)
        }
        
        self.currentFood = food
        
        return Observable.create { observer in
            
            observer.onNext(food)
            
            return NopDisposable.instance
        }
        
    }
    
}