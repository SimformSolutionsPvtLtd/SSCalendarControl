//
//  MonthModel.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 10/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import Foundation

class SSCalendarMonth {

    var monthNo: Int!
    var month: String!
    var year: Int!
    var days: [SSCalendarDay] = [SSCalendarDay]()
    
    init(monthNo: Int, month: String, year: Int) {
        self.monthNo = monthNo
        self.month = month
        self.year = year
        let totalDays = getNumberOfDays(year: year, month: monthNo)
        self.days = createModelArray(from: totalDays, year: year, month: monthNo)
    }
    
    func createModelArray(from days: Int, year: Int, month: Int) -> [SSCalendarDay] {
        var arrDays = [SSCalendarDay]()
        for i in 1...days {
            arrDays.append(SSCalendarDay(day: i))
        }
        return arrDays
    }

}

class SSCalendarDay {
    
    var day: Int!
    var isSelected = false
    
    init(day: Int) {
        self.day = day
    }
    
}
