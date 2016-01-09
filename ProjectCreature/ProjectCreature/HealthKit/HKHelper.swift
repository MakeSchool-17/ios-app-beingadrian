//
//  HKHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 11/14/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import Foundation
import HealthKit
import RxSwift


class HKHelper {
    
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
    
    private var healthStore: HKHealthStore? {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }

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
                
                if let error = error {
                    observer.onError(error)
                }
                
                observer.onNext(success)
                observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
        
    }
    
    // MARK: - Pre-methods

    private func createPredicate(from startDate: NSDate, to endDate: NSDate) -> NSPredicate {
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
        
        return predicate

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
    
    private func createStatisticsQuery(forQuantityType quantityType: HKQuantityType, predicate: NSPredicate, unit: HKUnit) -> Observable<Double> {
        
        guard let healthStore = self.healthStore else {
            return failWith(HKErrorType.NoHealthStore)
        }
        
        return create { observer in
            let queryOptions: HKStatisticsOptions = [.CumulativeSum, .SeparateBySource]
            
            let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: queryOptions) {
                (query, result, error) in
                
                if let error = error {
                    observer.onError(HKErrorType.DefaultError(error))
                    return
                }
                
                guard let result = result else {
                    observer.onError(HKErrorType.NoResult)
                    return
                }
                
                guard let deviceSource = self.getDeviceSource(fromResult: result) else {
                    observer.onError(HKErrorType.NoDeviceSource)
                    return
                }
                
                guard let sumQuantity = result.sumQuantityForSource(deviceSource) else {
                    observer.onError(HKErrorType.NoSumQuantity)
                    return
                }
                
                let value = sumQuantity.doubleValueForUnit(unit)
                observer.onNext(value)
                observer.onCompleted()
                
            }

            healthStore.executeQuery(query)
            
            return NopDisposable.instance
        }
        
    }
    
    // MARK: - Health Queries
    
    func queryTotalStepCount(fromDate startDate: NSDate, toDate endDate: NSDate) -> Observable<Double> {
        
        let predicate = createPredicate(from: startDate, to: endDate)
        
        guard let stepsType = stepsType else {
            return failWith(HKErrorType.TypeNotAvailable)
        }
        
        return createStatisticsQuery(forQuantityType: stepsType, predicate: predicate, unit: HKUnit.countUnit())
        
    }
    
    func queryTotalDistanceOnFoot(fromDate startDate: NSDate, toDate endDate: NSDate) -> Observable<Double> {
        
        let predicate = createPredicate(from: startDate, to: endDate)
        
        guard let distanceOnFootType = distanceOnFootType else {
            return failWith(HKErrorType.TypeNotAvailable)
        }
        
        return createStatisticsQuery(forQuantityType: distanceOnFootType, predicate: predicate, unit: HKUnit.meterUnit())
        
    }
    
}

