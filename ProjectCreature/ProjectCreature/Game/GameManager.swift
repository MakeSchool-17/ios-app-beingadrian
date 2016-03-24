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

/**
 * The GameManager class manages the game logic of the application. 
 * Most of its functionality are reactive to changes in the data models
 * e.g. `Pet` and `User` and data changes due to the 
 * user interaction on scene layer.
 */
final class GameManager: NSObject, NSCoding {

    private var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    var statsStore: StatsStore
    
    var storeManager: StoreManager!
    var petManager: PetManager
    var foodManager: FoodManager!
    
    var user: User
    
    var lastClosedDate: NSDate?
    
    // MARK: - Initialization

    init(user: User, pet: Pet) {

        self.statsStore = StatsStore()
    
        self.petManager = PetManager(pet: pet)
        self.foodManager = FoodManager()
        
        self.user = user

        super.init()
        
        self.storeManager = StoreManager(gameManager: self)
        
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
    
        guard
            let statsStore = decoder.decodeObjectForKey("GMStatsStore") as? StatsStore,
            let user = decoder.decodeObjectForKey("GMUser") as? User,
            let petManager = decoder.decodeObjectForKey("GMPetManager") as? PetManager,
            let foodManager = decoder.decodeObjectForKey("GMFoodManager") as? FoodManager
        else {
            return nil
        }
        
        self.init(user: user, pet: petManager.pet)
        
        self.lastClosedDate = decoder.decodeObjectForKey("GMLastClosedDate") as? NSDate
        
        self.statsStore = statsStore
        self.petManager = petManager
        self.foodManager = foodManager
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(statsStore, forKey: "GMStatsStore")
        coder.encodeObject(petManager, forKey: "GMPetManager")
        coder.encodeObject(foodManager, forKey: "GMFoodManager")
        coder.encodeObject(user, forKey: "GMUser")
        coder.encodeObject(lastClosedDate, forKey: "GMLastClosedDate")
        
    }
    
}