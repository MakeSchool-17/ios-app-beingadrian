//
//  StorePopUpViewDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/6/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation

/**
 * A convenience protocol that handles the store pop up view's actions.
 * Makes the action accessable from the main view controller showing the pop up.
 */
protocol StorePopUpViewDelegate: class {
    
    func didTapConfirmButton()
    
}