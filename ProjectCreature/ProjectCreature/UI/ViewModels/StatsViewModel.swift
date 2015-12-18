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
    
    let statsHelper = HKStatsHelper()
    
    // MARK: - Properties
    
    var distance: Variable<Float>
    var progress: Variable<Float>
    
    var totalSteps: Variable<Int>
    var date: Variable<String>
    
    var sundayProgress: Variable<Float> = Variable(0)
    var mondayProgress: Variable<Float> = Variable(0)
    var tuesdayProgress: Variable<Float> = Variable(0)
    var wednesdayProgress: Variable<Float> = Variable(0)
    var thursdayProgress: Variable<Float> = Variable(0)
    var fridayProgress: Variable<Float> = Variable(0)
    var saturdayProgress: Variable<Float> = Variable(0)
    
    var pointerIndex: Variable<Int> = Variable(0)
    
    // MARK: - Initialization
    
    init() {
        
        self.distance = Variable(5.7)
        self.progress = Variable(66)
        
        self.totalSteps = Variable(10000)
        self.date = Variable("December 28, 2015")
        
        self.sundayProgress = Variable(0.8)
        
        bindDataToUI()
        
    }
    
    // MARK: - Model binding
    
    func bindDataToUI() {
        
        guard let todayIndex = statsHelper.getWeekdayFromDate(fromDate: NSDate()) else { return }
        self.pointerIndex.value = todayIndex
        
    }
    
    
}