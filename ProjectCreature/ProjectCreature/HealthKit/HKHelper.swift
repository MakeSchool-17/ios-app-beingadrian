//
//  HKHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import HealthKit
import PromiseKit

typealias HKRequestPermissionCallback = (success: Bool, error: NSError?) -> Void
typealias HKQueryCallback = (value: Double, error: NSError?) -> Void
typealias HKStepCountQueryCallback = (totalStepCount: Double?, error: NSError?) -> Void
typealias HKDistanceOnFootQueryCallback = (totalDistance: Double?, error: NSError?) -> Void


enum HKErrorType: ErrorType {
    case NoHealthStore
    case NoResult
    case NoDeviceSource
    case NoSumQuantity
    case TypeNotAvailable
    case DefaultError(NSError?)
}

class HKHelper {
    
    // MARK: - Typealias
    
    private typealias HKRequestAuthorizationToShareTypesAdapter = (Bool, NSError?) -> Void
    private typealias HKStepCountQueryAdapter = (Double, NSError?) -> Void
    private typealias HKDistanceOnFootQueryAdapter = (Double, NSError?) -> Void

    
    // MARK: - Propertoes
    
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
    
    func requestHealthKitAuthorization() -> Promise<Bool> {
        
        return Promise { (adapter: HKRequestAuthorizationToShareTypesAdapter) in
            guard let stepsType = self.stepsType, distanceOnFootType = self.distanceOnFootType else {
                return
            }
            
            let dataTypesToRead = Set<HKQuantityType>(arrayLiteral: stepsType, distanceOnFootType)
            
            guard let healthStore = self.healthStore else {
                // TODO: manage if healthStore is not available
                return
            }
            
            healthStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead, completion: adapter)
        }
        
    }
    
    
    // MARK: - Pre-methods 
    
    private func createPredicate(fromInterval interval: NSTimeInterval) -> NSPredicate {
        
        let date = NSDate(timeIntervalSince1970: interval)
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        return predicate
        
    }
    
    private func createStatisticsQuery(forQuantityType quantityType: HKQuantityType, predicate: NSPredicate, unit: HKUnit) -> Promise<Double> {
        
        return Promise { fulfill, reject in
            let queryOptions: HKStatisticsOptions = [.CumulativeSum, .SeparateBySource]
            
            let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: queryOptions) {
                (query, result, error) in
                
                if let error = error {
                    reject(HKErrorType.DefaultError(error))
                }
                
                guard let result = result else {
                    // error: there is no result
                    reject(HKErrorType.NoResult)
                    return
                }
                
                guard let deviceSource = self.getDeviceSource(fromResult: result) else {
                    // error: there is no device source
                    reject(HKErrorType.NoDeviceSource)
                    return
                }
                
                guard let sumQuantity = result.sumQuantityForSource(deviceSource) else {
                    // error: no sum quantity
                    reject(HKErrorType.NoSumQuantity)
                    return
                }
                
                let value = sumQuantity.doubleValueForUnit(unit)
                fulfill(value)
                
            }
            
            guard let healthStore = self.healthStore else {
                throw HKErrorType.NoHealthStore
            }
            healthStore.executeQuery(query)
            
        }
        
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
    
    func queryTotalStepCount(sinceTimeInterval timeInterval: NSTimeInterval) -> Promise<Int> {
        
        return Promise { fulfill, reject in
            
            let predicate = self.createPredicate(fromInterval: timeInterval)
            
            guard let stepsType = self.stepsType else {
                reject(HKErrorType.TypeNotAvailable)
                return
            }
            
            firstly {
                self.createStatisticsQuery(forQuantityType: stepsType, predicate: predicate, unit: HKUnit.countUnit())
            }.then { (value) -> Void in
                let stepCount = Int(value)
                fulfill(stepCount)
            }.error { (error) in
                reject(error)
            }
            
        }
        
    }
    
    func queryTotalDistanceOnFoot(sinceTimeInterval timeInterval: NSTimeInterval) -> Promise<Int> {
        
        return Promise { fulfill, reject in
            
            let predicate = self.createPredicate(fromInterval: timeInterval)
            
            guard let distanceOnFootType = self.distanceOnFootType else {
                reject(HKErrorType.TypeNotAvailable)
                return
            }
            
            firstly {
                self.createStatisticsQuery(forQuantityType: distanceOnFootType, predicate: predicate, unit: HKUnit.meterUnit())
            }.then { (value) -> Void in
                let stepCount = Int(value)
                fulfill(stepCount)
            }.error { (error) in
                reject(error)
            }
            
        }
        
    }
    
}

