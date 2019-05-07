//
//  HeaderView.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 10/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

class SSHeaderView: UICollectionReusableView {
    
    // MARK:- outlets
    @IBOutlet weak var lblDay1: UILabel!
    @IBOutlet weak var lblDay2: UILabel!
    @IBOutlet weak var lblDay3: UILabel!
    @IBOutlet weak var lblDay4: UILabel!
    @IBOutlet weak var lblDay5: UILabel!
    @IBOutlet weak var lblDay6: UILabel!
    @IBOutlet weak var lblDay7: UILabel!
    
    var configuration = SSCalendarConfiguration()
    
    var weekStartDay: WeekStartDay = .monday {
        didSet {
            setStartDay(weekStartDay)
        }
    }

    /// Awake from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetup()
    }
    
    fileprivate func initialSetup() {
        _ = [lblDay1, lblDay2, lblDay3, lblDay4, lblDay5, lblDay6, lblDay7].map({ (label) in
            label?.backgroundColor = configuration.weekDayLabelBackgroundColor
            label?.textColor = configuration.weekDayLabelTextColor
            label?.font = configuration.weekDayLabelFont
            label?.layer.borderColor = configuration.weekDayBorderColor.cgColor
            label?.layer.borderWidth = 1.0
        })
    }
    
    /// Set Start Day of week
    ///
    /// - Parameter day: Day (Sunday/ Monday)
    func setStartDay(_ day: WeekStartDay = .monday) {
        switch day {
        case .sunday:
            setSunday()
            break
        case .monday:
            setMonday()
            break
        }
    }
    
    /// Set Sunday as start day
    fileprivate func setSunday() {
        lblDay1.text = WeekDays.sunday.shortName
        lblDay2.text = WeekDays.monday.shortName
        lblDay3.text = WeekDays.tuesday.shortName
        lblDay4.text = WeekDays.wednesday.shortName
        lblDay5.text = WeekDays.thursday.shortName
        lblDay6.text = WeekDays.friday.shortName
        lblDay7.text = WeekDays.saturday.shortName
        initialSetup()
    }
    
    /// Set Monday as start day
    fileprivate func setMonday() {
        lblDay1.text = WeekDays.monday.shortName
        lblDay2.text = WeekDays.tuesday.shortName
        lblDay3.text = WeekDays.wednesday.shortName
        lblDay4.text = WeekDays.thursday.shortName
        lblDay5.text = WeekDays.friday.shortName
        lblDay6.text = WeekDays.saturday.shortName
        lblDay7.text = WeekDays.sunday.shortName
        initialSetup()
    }
    
}
