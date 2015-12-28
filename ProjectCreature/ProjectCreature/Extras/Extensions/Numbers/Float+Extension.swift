//
//  Float+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


extension Float {
    
    /**
     * Clamps a value to a given range.
     *
     * - parameter range: The range for the clamp.
     * - returns: The clamped value.
     */
    func clamped(range: Range<Int>) -> Float {
        
        if (self < Float(range.startIndex)) {
            return Float(range.startIndex - 1)
        }
        
        if (self >= Float(range.endIndex)) {
            return Float(range.endIndex - 1)
        }
        
        return self
        
    }
    
}