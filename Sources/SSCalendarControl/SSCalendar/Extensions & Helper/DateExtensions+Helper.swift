//
//  DateExtensions+Helper.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 11/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import Foundation

class SSCalendarHelper {
    
    /// Returns date from the day, month and year
    ///
    /// - Parameters:
    ///   - year: year
    ///   - month: month
    ///   - day: day
    /// - Returns: Date from given parameters
    class func getDateFrom(year: Int, month: Int, day: Int) -> Date? {
        
        var dateComponents = DateComponents(year: year, month: month, day: day)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            return date
        }
        return nil
    }
    
    /// This returns day count of week day
    ///
    /// - Parameters:
    ///   - year: year
    ///   - month: month
    /// - Returns: Returns week day number for first date
    class func getDayOfWeekFrom(year: Int, month: Int) -> Int {
        var dateComponents = DateComponents(year: year, month: month)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents) ?? SSConstants.todayDate
        let day = calendar.component(.weekday, from: date)
        return day
    }
    
}

// MARK: - Date extension
extension Date {
    
    /// This returns date after given years and months
    ///
    /// - Parameters:
    ///   - years: years
    ///   - months: months
    /// - Returns: Retruns date after the given time
    public func getDateAfter(years: Int, months: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = years
        dateComponents.month = months
        if let date = Calendar.current.date(byAdding: dateComponents, to: self) {
            return date
        }
        return SSConstants.todayDate
    }
    
    /// Returns month details for date
    ///
    /// - Returns: Returns tuple of month count, year and month name
    func getMonth() -> (month: Int, year: Int, name: String) {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let formatter = DateFormatter()
        formatter.dateFormat = SSDateFormat.shortMonth
        let monthName = formatter.string(from: self)
        return (month, year, monthName)
    }
    
    /// This function returns if given date is same as another
    ///
    /// - Parameter date: Date to compare
    /// - Returns: Result in  boolean
    func isSame(_ date: Date?) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = SSDateFormat.ddMMyyyy
        guard let date = date else {
            return false
        }
        if formatter.string(from: self) == formatter.string(from: date) {
            return true
        }
        return false
    }
    
    /// This function checks that selected date is less than today or not
    ///
    /// - Returns: Result in boolean
    func isMinus() -> Bool {
        if self.timeIntervalSinceNow.sign != .plus && !self.isSame(SSConstants.todayDate) {
            return true
        }
        return false
    }
    
}

// MARK: - Optional Date extesnsion
extension Optional where Wrapped == Date {
    
    /// This function checks that selected date is less than today or not
    ///
    /// - Returns: Result in boolean
    func isMinus() -> Bool {
        if let date = self {
           return date.isMinus()
        }
        return false
    }
    
    /// This function returns if given date is same as another
    ///
    /// - Parameter date: Date to compare
    /// - Returns: Result in  boolean
    func isSame(_ date: Date?) -> Bool {
        if let selfDate = self {
            return selfDate.isSame(date)
        }
        return false
    }
    
}
