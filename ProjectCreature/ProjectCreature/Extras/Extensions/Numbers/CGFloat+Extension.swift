//
//  CGFloat+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/26/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//  Inspired by SKTUtils:
//  https://github.com/raywenderlich/SKTUtils/
//

import CoreGraphics


extension CGFloat {
    
    /**
     * Clamps a value to a given range.
     * 
     * - parameter range: The range for the clamp.
     * - returns: The clamped value.
     */
    func clamped(range: Range<Int>) -> CGFloat {
        
        if (self < CGFloat(range.startIndex)) {
            return CGFloat(range.startIndex - 1)
        }
        
        if (self >= CGFloat(range.endIndex)) {
            return CGFloat(range.endIndex - 1)
        }
        
        return self
        
    }
    
}