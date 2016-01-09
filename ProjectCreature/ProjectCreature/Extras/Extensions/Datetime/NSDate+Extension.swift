//
//  NSDate+Extension.swift
//  ProjectCreature
//
//  Created by Adrian Wisaksana on 12/17/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//  Inspiration:
//  - http://stackoverflow.com/questions/13324633/nsdate-beginning-of-day-and-end-of-day
//  - http://nshipster.com/nsdatecomponents/
//
//

import Foundation


extension NSDate {
    
    var weekday: Int {
        
        let calendar = NSCalendar.currentCalendar()
        let weekdayComponent = calendar.components(.Weekday, fromDate: self)
        
        return weekdayComponent.weekday
        
    }
    
    var startDay: NSDate {
        
        return NSCalendar.currentCalendar().startOfDayForDate(self)
        
    }
    
    var endOfDay: NSDate? {
        
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        
        let calendar = NSCalendar.currentCalendar()
        
        return calendar.dateByAddingComponents(components, toDate: startDay, options: NSCalendarOptions())
        
    }
    
    var localTimestamp: String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.locale = NSLocale.currentLocale()
        
        let localTimestamp = dateFormatter.stringFromDate(self)
        
        return localTimestamp
        
    }
    
    func getDateFromWeekday(weekday: Int) -> NSDate? {
        
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponent = calendar.components(
            [.Year, .Month, .WeekOfMonth, .Hour, .Minute, .Second],
            fromDate: self)
        
        dateComponent.weekday = weekday
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0
        
        return calendar.dateFromComponents(dateComponent)
        
    }
    
    
}