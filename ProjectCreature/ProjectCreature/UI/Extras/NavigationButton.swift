//
//  NavigationButton.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import SpriteKit


class NavigationButton: SKSpriteNode {
    
    weak var parentScene: SKScene?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        performFunction()
        
    }
    
    /**
        Performs block when `touchesBegan` is called.
    */
    func performFunction() {}
    
}
    

    
