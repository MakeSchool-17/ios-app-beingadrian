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


class HKStatsStore {
    
    private var disposeBag = DisposeBag()
    
    private let healthHelper = HKHelper()
    
    private let firebaseHelper = FirebaseHelper()
    
    enum StatsError: ErrorType {
        case ErrorGettingDate
    }
    
    // MARK: - Properties
    
    /**
     * Distance travelled today in Meters.
     */
    var distanceTravelledToday: Variable<Float> = Variable(0.0)
    var totalStepsToday: Variable<Double> = Variable(0.0)
    
    /**
     * Stores the progress associated with each weekday.
     *
     * - key: Weekday as an `Int`
     * - value: Progress between 0.0 and 1.0
     */
    var weekStore = Variable(Dictionary<Int, Float>())
    
    // MARK: - Init
    
    init() {
        
        reloadData()
        
    }
    
    func reloadData() {
        
        let currentWeekday = NSDate().weekday
        
        getDistanceForToday()
            .map { return Float($0) }
            .subscribeNext { distance in
                self.distanceTravelledToday.value = distance
            }
            .addDisposableTo(disposeBag)
        
        for weekday in 1...7 {
            
            getStepsForWeekday(weekday)
                .map { return Float($0) }
                .subscribeNext { steps in
                    // hardcode goal of 10000 at the moment
                    self.weekStore.value[weekday] = steps / 10_000
                }
                .addDisposableTo(disposeBag)
            
        }
        
        getStepsForWeekday(currentWeekday)
            .subscribeNext { steps in
                self.totalStepsToday.value = steps
            }
            .addDisposableTo(disposeBag)
        
    }
    
    // MARK: - Stats methods
    
    private func getDistanceForToday() -> Observable<Double> {
        
        return healthHelper.queryTotalDistanceOnFoot(
            fromDate: NSDate().startDay,
            toDate: NSDate())
        
    }
    
    private func getStepsForWeekday(weekday: Int) -> Observable<Double> {

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