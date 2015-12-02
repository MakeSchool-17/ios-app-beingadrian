//
//  HKHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import HealthKit
import RxSwift


class HKHelper {
    
    // MARK: - Typealias
    
    private typealias HKRequestAuthorizationToShareTypesAdapter = (Bool, NSError?) -> Void
    
    
    // MARK: - Error types 
    
    enum HKErrorType: ErrorType {
        case NoHealthStore
        case NoResult
        case NoDeviceSource
        case NoSumQuantity
        case TypeNotAvailable
        case DefaultError(NSError?)
    }
    
    // MARK: - Properties
    
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
    
    func requestHealthKitAuthorization() -> Observable<Bool> {
        
        guard let stepsType = self.stepsType, distanceOnFootType = self.distanceOnFootType else {
            return failWith(HKErrorType.TypeNotAvailable)
        }
        
        let dataTypesToRead = Set<HKQuantityType>(arrayLiteral: stepsType, distanceOnFootType)
        
        guard let healthStore = self.healthStore else {
            return failWith(HKErrorType.NoHealthStore)
        }
        
        return create { observer in
            healthStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead) {
                (success, error) in
                
                observer.on(.Next(success))
            }
            return NopDisposable.instance
        }
        
    }
    
    
    // MARK: - Pre-methods 
    
    private func createPredicate(fromInterval interval: NSTimeInterval) -> NSPredicate {
        
        let date = NSDate(timeIntervalSince1970: interval)
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        return predicate
        
    }
    
    private func createStatisticsQuery(forQuantityType quantityType: HKQuantityType, predicate: NSPredicate, unit: HKUnit) -> Observable<Double> {
        
        guard let healthStore = self.healthStore else {
            return failWith(HKErrorType.NoHealthStore)
        }
        
        return create { observer in
            let queryOptions: HKStatisticsOptions = [.CumulativeSum, .SeparateBySource]
            
            let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: queryOptions) {
                (query, result, error) in
                
                if let error = error {
                    observer.on(.Error(HKErrorType.DefaultError(error)))
                    return
                }
                
                guard let result = result else {
                    observer.on(.Error(HKErrorType.NoResult))
                    return
                }
                
                guard let deviceSource = self.getDeviceSource(fromResult: result) else {
                    observer.on(.Error(HKErrorType.NoDeviceSource))
                    return
                }
                
                guard let sumQuantity = result.sumQuantityForSource(deviceSource) else {
                    observer.on(.Error(HKErrorType.NoSumQuantity))
                    return
                }
                
                let value = sumQuantity.doubleValueForUnit(unit)
                return observer.on(.Next(value))
                
            }

            healthStore.executeQuery(query)
            
            return NopDisposable.instance
            
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
    
    func queryTotalStepCount(sinceTimeInterval timeInterval: NSTimeInterval) -> Observable<Int> {
        
        let predicate = self.createPredicate(fromInterval: timeInterval)
        
        guard let stepsType = self.stepsType else {
            return failWith(HKErrorType.TypeNotAvailable)
        }
        
        return self.createStatisticsQuery(forQuantityType: stepsType, predicate: predicate, unit: HKUnit.countUnit())
            .flatMap { value -> Observable<Int> in
                let stepCount = Int(value)
                return just(stepCount)
            }
        
    }
    
    func queryTotalDistanceOnFoot(sinceTimeInterval timeInterval: NSTimeInterval) -> Observable<Int> {
        
        let predicate = self.createPredicate(fromInterval: timeInterval)
        
        guard let distanceOnFootType = self.distanceOnFootType else {
            return failWith(HKErrorType.TypeNotAvailable)
        }
        
        return self.createStatisticsQuery(forQuantityType: distanceOnFootType, predicate: predicate, unit: HKUnit.meterUnit())
            .flatMap { value -> Observable<Int> in
                let distance = Int(value)
                return just(distance)
            }
        
    }
    
}

