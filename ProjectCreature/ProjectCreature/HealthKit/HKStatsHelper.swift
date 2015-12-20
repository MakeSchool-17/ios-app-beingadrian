//
//  HKStatsHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//

import Foundation
import RxSwift


class HKStatsHelper {
    
    private let healthHelper = HKHelper()
    
    enum StatsError: ErrorType {
        case ErrorGettingDate
    }
    
    // MARK: - Properties 
    
    
    
    // MARK: - Stats methods
    
    func getStepsForToday() -> Observable<Double> {
        
        return healthHelper.queryTotalStepCount(
            fromDate: NSDate().startDay,
            toDate: NSDate())
        
    }
    
    func getDistanceForToday() -> Observable<Double> {
        
        return healthHelper.queryTotalDistanceOnFoot(
            fromDate: NSDate().startDay,
            toDate: NSDate())
        
    }
    
    func getStepsForWeekday(weekday: Int) -> Observable<Double> {

        guard let day = NSDate().getDateFromWeekday(weekday) else {
            return failWith(StatsError.ErrorGettingDate) }
        
        guard let endOfDay = day.endOfDay else {
            return failWith(StatsError.ErrorGettingDate)
        }
        
        return healthHelper.queryTotalStepCount(
            fromDate: day.startDay,
            toDate: endOfDay)
        
    }
    
}