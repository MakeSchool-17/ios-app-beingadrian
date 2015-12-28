//
//  CGPoint+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/26/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit


extension CGPoint {
    
    /**
     * Calculates the distance to another point.
     *
     * - parameter point: The point to measure the distance to.
     * - returns: The distance.
     */
    func distanceTo(point: CGPoint) -> CGFloat {
        
        let dx = self.x - point.x
        let dy = self.y - point.y
        
        return sqrt(pow(dx, 2) + pow(dy, 2))
        
    }
    
}
