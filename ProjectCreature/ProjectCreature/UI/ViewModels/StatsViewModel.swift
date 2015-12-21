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
    
    let statsStore: HKStatsStore
    
    // MARK: - Properties
    
    var distance: Float = 0
    
    var totalSteps: Float = 0
    var date: String = ""
    
    var weekProgresss = Dictionary<Int, Float>()
    
    var pointerIndex: Int = 0
    
    // MARK: - Initialization
    
    init(statsStore: HKStatsStore) {
        
        self.statsStore = statsStore
        
        statsStore.distanceTravelledToday
            .map { return $0 / 1000 }
            .subscribeNext { distance in
                self.distance = distance
            }
            .addDisposableTo(disposeBag)
        
        statsStore.totalStepsToday
            .map { return Float($0) }
            .subscribeNext { steps in
                self.totalSteps = steps
            }
            .addDisposableTo(disposeBag)
        
        self.date = NSDate().localTimestamp
        
        let currentWeekday = NSDate().weekday
        
        self.pointerIndex = currentWeekday
        
        statsStore.weekStore
            .subscribeNext { weekStore in
                for (weekday, progress) in weekStore {
                    self.weekProgresss[weekday] = progress
                }
            }
            .addDisposableTo(disposeBag)
        
    }
    
}