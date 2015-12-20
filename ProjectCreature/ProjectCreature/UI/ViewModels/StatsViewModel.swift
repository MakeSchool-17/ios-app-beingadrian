//
//  StatsViewModel.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/6/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import RxSwift


class StatsViewModel {
    
    var disposeBag = DisposeBag()
    
    // TODO: Stats is leaking memory
    private let stats = HKStatsHelper()
    
    // MARK: - Properties
    
    var distance: Variable<Float> = Variable(0)
    var progress: Variable<Float> = Variable(0)
    
    var totalSteps: Variable<Int> = Variable(0)
    var date: Variable<String> = Variable("")
    
    var sundayProgress: Variable<Float> = Variable(0)
    var mondayProgress: Variable<Float> = Variable(0)
    var tuesdayProgress: Variable<Float> = Variable(0)
    var wednesdayProgress: Variable<Float> = Variable(0)
    var thursdayProgress: Variable<Float> = Variable(0)
    var fridayProgress: Variable<Float> = Variable(0)
    var saturdayProgress: Variable<Float> = Variable(0)
    
    var weekProgresses: [Variable<Float>]
    
    var pointerIndex: Variable<Int> = Variable(0)
    
    // MARK: - Initialization
    
    init() {
        
        self.weekProgresses = [sundayProgress, mondayProgress, tuesdayProgress, wednesdayProgress, thursdayProgress, fridayProgress, saturdayProgress]
        
        // temporary value
        self.progress.value = 75
        
        bindDataToUI()
        
    }
    
    // MARK: - Model binding
    
    private func bindDataToUI() {
        
        self.pointerIndex.value = NSDate().weekday
        
        stats.getStepsForToday()
            .subscribe(
                onNext: { (steps) -> Void in
                    let stepsString = Int(round(steps))
                    self.totalSteps.value = stepsString
                },
                onError: { (error) -> Void in
                    print("> Error getting steps: \(error)")
                },
                onCompleted: {}, onDisposed: {})
            .addDisposableTo(disposeBag)
        
        stats.getDistanceForToday()
            .subscribe(
                onNext: { (distance) -> Void in
                    self.distance.value = Float(distance)
                },
                onError: { (error) -> Void in
                    print("> Error getting distance: \(error)")
                },
                onCompleted: {}, onDisposed: {})
            .addDisposableTo(disposeBag)
        
        self.date.value = NSDate().localTimestamp
        
        for i in 0...(weekProgresses.count-1) {
            
            let dayProgress = weekProgresses[i]
            
            stats.getStepsForWeekday(i+1)
                .map { return Float($0) / 10000 }
                .subscribeNext { progress in
                    dayProgress.value = progress
                }
                .addDisposableTo(disposeBag)
            
        }
        
        
    }
    
}