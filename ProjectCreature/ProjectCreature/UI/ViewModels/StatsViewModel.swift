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
         
        gameManager.statsStore.rx_observe(Double.self, "distanceTravelledToday")
            .map {
                guard let distance = $0 else { return 0 }
                return Float(distance / 1000)
            }
            .subscribeNext { distance in
                self.distance = distance
            }
            .addDisposableTo(disposeBag)
        
        gameManager.statsStore.rx_observe(Double.self, "totalStepsToday")
            .map {
                guard let steps = $0 else { return 0 }
                return Float(steps)
            }
            .subscribeNext { steps in
                self.totalSteps = steps
            }
            .addDisposableTo(disposeBag)
        
        self.date = NSDate().localTimestamp
        
        self.currentWeekday = NSDate().weekday
        
        gameManager.statsStore.rx_observe(Dictionary.self, "weekProgress")
            .subscribeNext { (weekProgress: Dictionary<Int, Double>?) in
                guard let weekProgress = weekProgress else { return }
                self.weekProgress = weekProgress
            }
            .addDisposableTo(disposeBag)
        
    }
    
}

extension StatsViewModel: RxCompliant {}
