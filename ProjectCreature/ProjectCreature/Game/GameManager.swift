//
//  GameManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/20/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift
import SpriteKit
import RealmSwift

/**
 * The GameManager class manages the game logic of the application. 
 * Most of its functionality are reactive to changes in the data models
 * e.g. `Pet` and `User` and data changes due to the 
 * user interaction on scene layer.
 */
class GameManager: Object {

    private var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    dynamic var statsStore: StatsStore?
    
    var storeManager: StoreManager?
    dynamic var petManager: PetManager?
    dynamic var foodManager: FoodManager?
    
    dynamic var user: User = User()
    
    // MARK: - Create
    
    static func create(user: User, pet: Pet) -> GameManager {
        
        let gameManager = GameManager()
        
        gameManager.statsStore = StatsStore()
        gameManager.petManager = PetManager.create(pet)
        gameManager.foodManager = FoodManager()
        
        gameManager.user = user
        
        gameManager.storeManager = StoreManager(gameManager: gameManager)
        
        return gameManager
        
    }

}