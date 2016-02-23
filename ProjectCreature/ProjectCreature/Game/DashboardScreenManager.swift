//
//  DashboardManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/3/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


class DashboardScreenManager {
    
    var disposeBag = DisposeBag()
    
    enum FoodError: ErrorType {
        case FoodAlreadyExists
    }
    
    // MARK: - Properties
    
    private var gameManager: GameManager
    
    var currentFood: Variable<Food?>
    
    // level ups
    var petLeveledUp = PublishSubject<Int>()
    var expDifference: Float = 0
    
    // MARK: - Initialization 
    
    init(gameManager: GameManager) {
        
        self.gameManager = gameManager
        
        self.currentFood = Variable(nil)
        
    }
    
    private func makeObservations() {
        
        
        
    }
    
    // MARK: - Feeding
    
    // ...
    
    // MARK: - Petting
    
    // ...
    
}