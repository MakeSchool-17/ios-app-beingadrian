//
//  Achievement.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 1/31/16.
//  Copyright © 2016 BeingAdrian. All rights reserved.
//

import Foundation
import UIKit


class Achievement {
    
    // MARK: - Properties
    
    var title: String
    var description: String
    var image: UIImage
    
    // MARK: - Initialization
    
    init(title: String, description: String, image: UIImage) {
        
        self.title = title
        self.description = description
        self.image = image
        
    }
    
}