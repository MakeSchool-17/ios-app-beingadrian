//
//  HKStatsHelper.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


class HKStatsHelper {
    
    let healthHelper = HKHelper()
    
    // MARK: - Properties 
    
    
    
    // MARK: - Date methods 
    
    func getWeekdayFromDate(fromDate date: NSDate) -> Int? {
        
        guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else { return nil }
        calendar.locale = NSLocale.currentLocale()
        
        let weekdayComponent = calendar.components(.Weekday, fromDate: date)
        
        let weekday = weekdayComponent.weekday
        
        return weekday
        
    }
    
    func getDayFromWeekday(fromDate date: NSDate, weekday: Int) -> NSDate? {
        
        guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else { return nil }
        calendar.locale = NSLocale.currentLocale()
        
        let dateComponent = calendar.components([.Year, .Month, .WeekOfMonth, .Hour, .Minute, .Second], fromDate: date)
        
        dateComponent.weekday = weekday
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0
    
        let date = calendar.dateFromComponents(dateComponent)
        
        return date
        
    }

    func getLocalTimeString(fromDate date: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.locale = NSLocale.currentLocale()
        
        let localDateString = dateFormatter.stringFromDate(date)
        
        
        return localDateString
        
    }
    

    
}