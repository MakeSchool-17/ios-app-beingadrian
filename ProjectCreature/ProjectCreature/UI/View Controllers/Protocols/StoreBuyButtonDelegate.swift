//
//  StoreBuyButtonDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


protocol StoreBuyButtonDelegate: class {
    
    func didTapBuyButton(storeItem: StoreItem)
    
}