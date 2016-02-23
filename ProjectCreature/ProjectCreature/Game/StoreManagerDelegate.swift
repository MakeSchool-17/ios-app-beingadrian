//
//  StoreManagerDelegate.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 2/9/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation


protocol StoreManagerDelegate: class {
    
    func didPurchaseItem(item: StoreItem)
    
}

