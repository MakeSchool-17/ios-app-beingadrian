//
//  GameManager.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/20/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import PromiseKit


class GameManager {
    
    let healthHelper = HKHelper()
    let parseHelper = ParseHelper()
    
    enum HKData {
        case StepCount
        case DistanceOnFoot
    }
    
    
    // MARK: - Conversions
    
    func convertToExpFrom(healthData: HKData) -> Promise<Double> {
        
        switch healthData {
        case .StepCount:
            // convertion calculations here
            return Promise(1)
        case .DistanceOnFoot:
            // convertion calculations here
            return Promise(1)
        }
        
    }

    
    
}