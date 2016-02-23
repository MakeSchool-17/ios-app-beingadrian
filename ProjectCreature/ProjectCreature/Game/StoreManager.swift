//
//  StoreManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/2/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


class StoreManager {
    
    // MARK: - Properties
    
    private var gameManager: GameManager
    
    var items: [StoreItem] = []
    
    // MARK: - Initialization
    
    init(gameManager: GameManager) {
        
        self.gameManager = gameManager
        
    }
    
    // MARK: - Methods
    
    func purchaseItem(item: StoreItem) {
        
        // check if item is food
        // if food, handle food purchase
        // if not food, handle item purchase
        
    }
    
}