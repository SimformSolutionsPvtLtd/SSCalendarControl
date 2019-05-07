//
//  ViewController.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 10/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var calendarView: SSCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        self.calendarView.delegate = self
        setupCalendar()
    }
    
    /// Setup without selectable date range
    fileprivate func setupCalendar() {
        /// Configuration
        calendarView.configuration.monthViewBackgroundColor = UIColor.white
        calendarView.configuration.monthViewBottomLineColor = UIColor.darkGray
        calendarView.configuration.weekDayLabelBackgroundColor = UIColor.clear
        calendarView.configuration.weekDayLabelTextColor = UIColor.black
        calendarView.configuration.previousDayTextColor = UIColor.black
        calendarView.configuration.previousDayBorderColor = UIColor.clear
        calendarView.configuration.upcomingDaysBorderColor = UIColor.clear
        calendarView.configuration.monthLabelFont = UIFont.systemFont(ofSize: 20)
        calendarView.configuration.monthLabelTextColor = UIColor.red
        calendarView.configuration.upcomingDaysBorderColor = UIColor.clear
        calendarView.configuration.upcomingDayTextColor = UIColor.brown
        calendarView.configuration.selectedDayTextColor = UIColor.yellow
        calendarView.configuration.currentDayBorderColor = UIColor.black
        calendarView.configuration.currentDayTextColor = UIColor.white
        calendarView.configuration.currentDayBackgroundColor = UIColor.red
        /// Setup
        // Calender start date and end date
        let startDate = SSConstants.todayDate
        let endDate = startDate.getDateAfter(years: 1, months: 1)
        calendarView.setUpCalendar(startDate: startDate, endDate: endDate, weekStartDay: .monday, shouldSelectPastDays: true, sholudAllowMultipleSelection: false)
    }
    
}

extension MainViewController: SSCalendarDeleagte {

    func dateSelected(_ date: Date) {
        print("Selected Date: \(date)")
    }
    
    func dateDeSelected(_ date: Date) {
        print("DeSelected Date: \(date)")
    }

}
