//
//  Double+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


extension Double {
    
    /**
     * Clamps a value to a given range.
     *
     * - parameter range: The range for the clamp.
     * - returns: The clamped value.
     */
    func clamped(range: Range<Int>) -> Double {
        
        if (self < Double(range.startIndex)) {
            return Double(range.startIndex - 1)
        }
        
        if (self >= Double(range.endIndex)) {
            return Double(range.endIndex - 1)
        }
        
        return self
        
    }
    
}