//
//  ButtonProtocol.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/3/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


protocol Button {
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    
    func performAction()
    
}