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


struct StatsStore {
    
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
    var distanceTravelledToday: Variable<Double> = Variable(0.0)
    var totalStepsToday: Variable<Double> = Variable(0.0)
    
    /**
     * An observable dictionary containing the week progresses between `0.0` and `1.0`.
     */
    var weekProgress = Variable(Dictionary<Int, Double>())
    
    // MARK: - Data reloading
    
    func reloadData() -> Observable<Void> {
            
        let currentWeekday = NSDate().weekday
            
        return self.getDistanceForToday()
            .catchError { error in
                return just(0.0)
            }
            .flatMap { distanceToday -> Observable<Double> in
                self.distanceTravelledToday.value = distanceToday
                return self.getStepsForWeekday(currentWeekday)
                    .catchError { error in
                        return just(0.0)
                    }
            }.flatMap { stepsToday -> Observable<[Int: Double]> in
                self.totalStepsToday.value = stepsToday
                return self.getWeekProgress()
            }.flatMap { weekProgress -> Observable<Void> in
                self.weekProgress.value = weekProgress
                return empty()
            }

    }
    
    // MARK: - HK methods
    
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
    
    private func getWeekProgress() -> Observable<[Int: Double]> {
        
        var weekProgress: [Int: Double] = [:]
        
        return create { observer in
            
            self.getStepsForWeekday(1)
                .flatMap { sun -> Observable<Double> in
                    weekProgress[1] = sun / 10_000
                    return self.getStepsForWeekday(2)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return empty()
                    }
                }.flatMap { mon -> Observable<Double> in
                    weekProgress[2] = mon / 10_000
                    return self.getStepsForWeekday(3)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return empty()
                    }
                }.flatMap { tue -> Observable<Double> in
                    weekProgress[3] = tue / 10_000
                    return self.getStepsForWeekday(4)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return empty()
                    }
                }.flatMap { wed -> Observable<Double> in
                    weekProgress[4] = wed / 10_000
                    return self.getStepsForWeekday(5)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return empty()
                    }
                }.flatMap { thu -> Observable<Double> in
                    weekProgress[5] = thu / 10_000
                    return self.getStepsForWeekday(6)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return empty()
                    }
                }.flatMap { fri -> Observable<Double> in
                    weekProgress[6] = fri / 10_000
                    return self.getStepsForWeekday(7)
                        .catchError { error in
                            observer.onNext(weekProgress)
                            observer.onCompleted()
                            return empty()
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