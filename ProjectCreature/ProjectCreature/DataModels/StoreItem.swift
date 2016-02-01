//
//  StoreItem.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import UIKit


class StoreItem {
    
    // MARK: - Properties
    
    var title: String
    var description: String
    var price: Double
    var image: UIImage
    
    // MARK: - Initialization
    
    init(title: String, description: String, price: Double, image: UIImage) {
        
        self.title = title
        self.description = description
        self.price = price
        self.image = image
        
    }
    
}