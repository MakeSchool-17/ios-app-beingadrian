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
    
    // MARK: - Properties
    
    var distance: Float = 0
    
    var totalSteps: Float = 0
    var date: String = ""
    
    var weekProgress = Dictionary<Int, Double>()

    var currentWeekday = 0
    
    // MARK: - Initialization
    
    init(gameManager: GameManager) {
        
        gameManager.statsStore.distanceTravelledToday
            .map { return Float($0 / 1000) }
            .subscribeNext { distance in
                self.distance = distance
            }
            .addDisposableTo(disposeBag)
        
        gameManager.statsStore.totalStepsToday
            .map { return Float($0) }
            .subscribeNext { steps in
                self.totalSteps = steps
            }
            .addDisposableTo(disposeBag)
        
        self.date = NSDate().localTimestamp
        
        self.currentWeekday = NSDate().weekday
        
        gameManager.statsStore.weekProgress
            .subscribeNext { weekProgress in
                self.weekProgress = weekProgress
            }
            .addDisposableTo(disposeBag)
        
    }
    
}

extension StatsViewModel: RxCompliant {}
