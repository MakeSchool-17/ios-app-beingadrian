//
//  HKStatsStore.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//

import Foundation
import RxSwift
import RealmSwift


class StatsStore: Object {
    
    private var disposeBag = DisposeBag()
    
    private let healthHelper = HKHelper()
    
    private let firebaseHelper = FirebaseHelper()
    
    enum StatsError: ErrorType {
        case ErrorGettingDate
    }
    
    // MARK: - Properties
    
    dynamic var lastReloadDate: NSDate?
    dynamic var newSteps: Double = 0
    
    /**
     * Distance travelled today in Meters.
     */
    dynamic var distanceTravelledToday: Double = 0
    dynamic var totalStepsToday: Double = 0
    
    /**
     * An observable dictionary containing the week progresses between `0.0` and `1.0`.
     */
    dynamic var weekProgress = Dictionary<Int, Double>()
    
    // MARK: - Data reloading
    
    /**
     * Reloads the stats store's property values.
     * 
     * Sets the `lastReloadDate` property to a new `NSDate`.
     */
    func reloadData() -> Observable<Void> {
            
        let currentWeekday = NSDate().weekday
        
        return getNewSteps()
            .catchError { error in
                print("> Error getting new steps: \(error)")
                return Observable.just(0.0)
            }.flatMap { newSteps -> Observable<Double> in
                self.newSteps = newSteps
                return self.getDistanceForToday()
                    .catchError { error in
                        print("> Error getting distance for today: \(error)")
                        return Observable.just(0.0)
                    }
            }.flatMap { distanceToday -> Observable<Double> in
                self.distanceTravelledToday = distanceToday
                return self.getStepsForWeekday(currentWeekday)
                    .catchError { error in
                        return Observable.just(0.0)
                    }
            }.flatMap { stepsToday -> Observable<[Int: Double]> in
                self.totalStepsToday = stepsToday
                return self.getWeekProgress()
            }.flatMap { weekProgress -> Observable<Void> in
                self.weekProgress = weekProgress
                self.lastReloadDate = NSDate()
                return Observable.empty()
            }

    }
    
    // MARK: - HK methods
    
    private func getDistanceForToday() -> Observable<Double> {
        
        return healthHelper.queryTotalDistanceOnFoot(
            fromDate: NSDate().startDay,
            toDate: NSDate())
        
    }
    
    private func getNewSteps() -> Observable<Double> {
        
        let past: NSTimeInterval = -60 * 60 * 2
        let newDate = NSDate().dateByAddingTimeInterval(past)
        
        if lastReloadDate == nil {
            lastReloadDate = newDate
        }
        
        guard let lastReloadDate = self.lastReloadDate else {
            return Observable.just(0.0)
        }
        
        return healthHelper.queryTotalStepCount(
            fromDate: lastReloadDate,
            toDate: NSDate())
        
    }
    
    private func getStepsForWeekday(weekday: Int) -> Observable<Double> {

        guard let day = NSDate().getDateFromWeekday(weekday) else {
            return Observable.error(StatsError.ErrorGettingDate) }
        
        guard let endOfDay = day.endOfDay else {
            return Observable.error(StatsError.ErrorGettingDate)
        }
        
        return healthHelper.queryTotalStepCount(
            fromDate: day.startDay,
            toDate: endOfDay)
        
    }
    
    private func getWeekProgress() -> Observable<[Int: Double]> {
        
        var weekProgress: [Int: Double] = [:]
        
        return Observable.create { observer in
            
            self.getStepsForWeekday(1)
                .catchError { error in
                    observer.onNext(weekProgress)
                    observer.onCompleted()
                    return Observable.empty()
                }
                .flatMap { sun -> Observable<Double> in
                    weekProgress[1] = sun / 10_000
                    return self.getStepsForWeekday(2)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return Observable.empty()
                        }
                }.flatMap { mon -> Observable<Double> in
                    weekProgress[2] = mon / 10_000
                    return self.getStepsForWeekday(3)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return Observable.empty()
                        }
                }.flatMap { tue -> Observable<Double> in
                    weekProgress[3] = tue / 10_000
                    return self.getStepsForWeekday(4)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return Observable.empty()
                        }
                }.flatMap { wed -> Observable<Double> in
                    weekProgress[4] = wed / 10_000
                    return self.getStepsForWeekday(5)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return Observable.empty()
                        }
                }.flatMap { thu -> Observable<Double> in
                    weekProgress[5] = thu / 10_000
                    return self.getStepsForWeekday(6)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return Observable.empty()
                        }
                }.flatMap { fri -> Observable<Double> in
                    weekProgress[6] = fri / 10_000
                    return self.getStepsForWeekday(7)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return Observable.empty()
                        }
                }.subscribeNext { sat in
                    weekProgress[7] = sat / 10_000
                    observer.onNext(weekProgress)
                    observer.onCompleted()
                }.addDisposableTo(self.disposeBag)
            
            return NopDisposable.instance
        }
        
    }
    
}