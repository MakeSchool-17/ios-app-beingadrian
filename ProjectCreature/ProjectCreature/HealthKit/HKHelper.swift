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
        
        guard let stepsType = self.stepsType else { return }
        guard let distanceOnFootType = self.distanceOnFootType else { return }
        
        let dataTypesToRead = Set<HKQuantityType>(arrayLiteral: stepsType, distanceOnFootType)

        guard let healthStore = self.healthStore else {
            // TODO: manage if healthStore is not available
            return
        }
        
        healthStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead) {
            (success, error) in
            
            completion(success: success, error: error)
        }
        
    }
    
    
    // MARK: - Health Queries
    
    func queryTotalStepCount(sinceTimeInterval timeInterval: NSTimeInterval, completion: HKStepCountQueryCallback) {
        
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        guard let stepsType = self.stepsType else { return }
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        let option = HKStatisticsOptions.SeparateBySource
        
        let stepCountQuery = HKStatisticsQuery(quantityType: stepsType, quantitySamplePredicate: predicate, options: [sumOption, option]) {
            (query, result, error) in
            
            guard let result = result else {
                // TODO: Handle error
                print("There is no result")
                completion(totalStepCount: nil, error: error)
                return
            }
            
            let deviceName = UIDevice.currentDevice().name
            
            guard let sources = result.sources else {
                completion(totalStepCount: nil, error: error)
                return
            }
            
            let sourcesFiltered = sources.filter { $0.name == deviceName }
            
            if (sourcesFiltered.count != 0) {
                let deviceSource = sourcesFiltered[0]
                guard let sumQuantity = result.sumQuantityForSource(deviceSource) else {
                    // no sum quantity
                    completion(totalStepCount: nil, error: error)
                    return
                }
                let totalStepCount = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
                completion(totalStepCount: totalStepCount, error: error)
            } else {
                // there is no device source
                completion(totalStepCount: nil, error: error)
            }
        
        }
        
        guard let healthStore = self.healthStore else { return }
        healthStore.executeQuery(stepCountQuery)
        
    }
    
    func queryTotalDistanceOnFoot(sinceTimeInterval timeInterval: NSTimeInterval, completion: HKDistanceOnFootQueryCallback) {
        
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        guard let distanceOnFootType = self.distanceOnFootType else { return }
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let distanceOnFootQuery = HKStatisticsQuery(quantityType: distanceOnFootType, quantitySamplePredicate: predicate, options: sumOption) {
            (query, result, error) in
            
            guard let result = result else {
                // TODO: Handle error
                print("There is no result")
                completion(totalDistance: nil, error: error)
                return
            }
            
            let deviceName = UIDevice.currentDevice().name
            
            guard let sources = result.sources else {
                completion(totalDistance: nil, error: error)
                return
            }
            
            let sourcesFiltered = sources.filter { $0.name == deviceName }
            
            if (sourcesFiltered.count != 0) {
                let deviceSource = sourcesFiltered[0]
                guard let sumQuantity = result.sumQuantityForSource(deviceSource) else {
                    // no sum quantity
                    completion(totalDistance: nil, error: error)
                    return
                }
                let totalDistanceOnFoot = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
                completion(totalDistance: totalDistanceOnFoot, error: error)
            } else {
                // there is no device source
                completion(totalDistance: nil, error: error)
            }
        }
        
        guard let healthStore = self.healthStore else  { return }
        healthStore.executeQuery(distanceOnFootQuery)
        
    }
    
}

