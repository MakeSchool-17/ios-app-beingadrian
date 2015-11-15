//
//  HKHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import HealthKit


typealias HKRequestPermissionCallback = (success: Bool, error: NSError?) -> Void
typealias HKStepCountQueryCallback = (totalStepCount: Double?, error: NSError?) -> Void
typealias HKDistanceOnFootQueryCallback = (totalDistance: Double?, error: NSError?) -> Void


class HKHelper {
    
    // get health store
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            // TODO: Health data not avialable
            return nil
        }
    }()

    
    // MARK: - Types to read
    
    let stepsType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierStepCount
    )
    
    let distanceOnFootType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierDistanceWalkingRunning
    )
    
    
    // MARK: - Request permissions
    
    func requestHealthKitAuthorization(completion: HKRequestPermissionCallback) {
        
        guard let stepsType = self.stepsType else {
            // TODO: Handle if steps data is not available
            return
        }
        
        guard let distanceOnFootType = self.distanceOnFootType else {
            // TODO: Handle if distance walked and run data is not available
            return
        }
        
        let dataTypesToRead = Set<HKQuantityType>(arrayLiteral: stepsType, distanceOnFootType)

        guard let healthStore = self.healthStore else {
            return
        }
        
        healthStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead) {
            (success, error) in
            
            completion(success: success, error: error)
        }
        
    }
    
    
    // MARK: - Health Queries
    
    func queryTotalStepCountSinceDate(completion: HKStepCountQueryCallback) {
        
        guard let stepsType = self.stepsType else { return }
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let stepCountQuery = HKStatisticsQuery(quantityType: stepsType, quantitySamplePredicate: nil, options: sumOption) {
            (query, result, error) in
            
            if let result = result {
                guard let sumQuantity = result.sumQuantity() else { return }
                let totalStepCount = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
                completion(totalStepCount: totalStepCount, error: error)
            } else {
                // TODO: Handle no result
                print("There is no result")
            }
        }
        
        guard let healthStore = self.healthStore else { return }
        healthStore.executeQuery(stepCountQuery)
        
    }
    
    func queryTotalDistanceOnFoot(completion: HKDistanceOnFootQueryCallback) {
        
        guard let distanceOnFootType = self.distanceOnFootType else { return }
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let distanceOnFootQuery = HKStatisticsQuery(quantityType: distanceOnFootType, quantitySamplePredicate: nil, options: sumOption) {
            (query, result, error) in
            
            if let result = result {
                guard let sumQuantity = result.sumQuantity() else { return }
                let totalDistanceOnFoot = sumQuantity.doubleValueForUnit(HKUnit.meterUnit())
                completion(totalDistance: totalDistanceOnFoot, error: error)
            } else {
                // TODO: Handle no result
                print("There is no result")
            }
        }
        
        guard let healthStore = self.healthStore else  { return }
        healthStore.executeQuery(distanceOnFootQuery)
        
    }
    
}

