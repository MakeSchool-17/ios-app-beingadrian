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
typealias HKQueryCallback = (value: Double?, error: HKQueryErrorType?) -> Void
typealias HKStepCountQueryCallback = (totalStepCount: Double?, error: HKQueryErrorType?) -> Void
typealias HKDistanceOnFootQueryCallback = (totalDistance: Double?, error: HKQueryErrorType?) -> Void


enum HKQueryErrorType: ErrorType {
    case NoResult
    case NoDeviceSource
    case NoSumQuantity
    case DefaultError(NSError?)
}

class HKHelper {
    
    private let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()

    
    // MARK: - Types to read
    
    private let stepsType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierStepCount
    )
    
    private let distanceOnFootType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierDistanceWalkingRunning
    )
    
    
    // MARK: - Request permissions
    
    func requestHealthKitAuthorization(completion: HKRequestPermissionCallback) {
        
        guard let stepsType = self.stepsType, distanceOnFootType = self.distanceOnFootType else {
            return
        }
        
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
    
    
    // MARK: - Pre-methods 
    
    private func createPredicate(fromInterval interval: NSTimeInterval) -> NSPredicate {
        
        let date = NSDate(timeIntervalSince1970: interval)
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        return predicate
        
    }
    
    private func createStatisticsQuery(forQuantityType quantityType: HKQuantityType, predicate: NSPredicate, unit: HKUnit, completion: HKQueryCallback) -> HKStatisticsQuery {
        
        let queryOptions: HKStatisticsOptions = [.CumulativeSum, .SeparateBySource]
        
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: queryOptions) {
            (query, result, error) in
            
            if let error = error {
                completion(value: nil, error: .DefaultError(error))
            }
            
            guard let result = result else {
                // error: there is no result
                completion(value: nil, error: .NoResult)
                return
            }
            
            guard let deviceSource = self.getDeviceSource(fromResult: result) else {
                // error: there is no device source
                completion(value: nil, error: .NoDeviceSource)
                return
            }
            
            guard let sumQuantity = result.sumQuantityForSource(deviceSource) else {
                // error: no sum quantity
                completion(value: nil, error: .NoSumQuantity)
                return
            }
            
            let value = sumQuantity.doubleValueForUnit(unit)
            completion(value: value, error: nil)
            
        }
        
        return query
        
    }
    
    private func getDeviceSource(fromResult result: HKStatistics) -> HKSource? {
        
        let deviceName = UIDevice.currentDevice().name
        
        guard let sources = result.sources else {
            return nil
        }
        
        let sourcesFiltered = sources.filter { $0.name == deviceName }
        
        if (sourcesFiltered.count != 0) {
            let deviceSource = sourcesFiltered[0]
            return deviceSource
        } else {
            return nil
        }
        
    }
    
    
    // MARK: - Health Queries
    
    func queryTotalStepCount(sinceTimeInterval timeInterval: NSTimeInterval, completion: HKStepCountQueryCallback) {
        
        let predicate = self.createPredicate(fromInterval: timeInterval)
        
        guard let stepsType = self.stepsType else { return }
        
        let stepCountQuery = self.createStatisticsQuery(forQuantityType: stepsType, predicate: predicate, unit: HKUnit.countUnit()) {
            completion(totalStepCount: $0, error: $1)
        }
        
        guard let healthStore = self.healthStore else { return }
        healthStore.executeQuery(stepCountQuery)
        
    }
    
    func queryTotalDistanceOnFoot(sinceTimeInterval timeInterval: NSTimeInterval, completion: HKDistanceOnFootQueryCallback) {
        
        let predicate = self.createPredicate(fromInterval: timeInterval)
        
        guard let distanceOnFootType = self.distanceOnFootType else { return }
        
        let distanceOnFootQuery = self.createStatisticsQuery(forQuantityType: distanceOnFootType, predicate: predicate, unit: HKUnit.meterUnit()) {
            completion(totalDistance: $0, error: $1)
        }
        
        guard let healthStore = self.healthStore else { return }
        healthStore.executeQuery(distanceOnFootQuery)
        
    }
    
}

