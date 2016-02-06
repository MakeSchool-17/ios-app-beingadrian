//
//  StoreBuyButtonDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation

/**
 * A convenience protocol that handles the store buy button's actions.
 * Makes the action accessable from the main view controller showing the pop up.
 */
protocol StoreBuyButtonDelegate: class {
    
    /**
     * Called when the buy button is tapped.
     *
     * - parameter storeItem: The selected store item.
     */
    func didTapBuyButton(storeItem: StoreItem)
    
}