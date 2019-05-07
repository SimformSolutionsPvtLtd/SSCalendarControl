//
//  DaysCell.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 10/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

/// Days Cell
class SSDaysCell: UICollectionViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    var monthIndexPath: IndexPath!
    
    var currentMonth: Int!
    var currentYear: Int!
    var configuration = SSCalendarConfiguration()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupContentView()
    }
    
    fileprivate func setupContentView() {
        viewContent.layer.cornerRadius = configuration.shouldRoundDaysView ? viewContent.bounds.height/2 : 0
    }
    
    fileprivate func initialSetup() {
        lblName.font = configuration.dayLabelFont
        viewContent.layer.borderWidth = 1.0
    }
    
    fileprivate func setUpTodayLabel(model: SSCalendarDay) {
        if SSConstants.todayDate.isSame(getDate(model: model)) {
            lblName.textColor = configuration.currentDayTextColor
            viewContent.backgroundColor = configuration.currentDayBackgroundColor
            viewContent.layer.borderColor = configuration.currentDayBorderColor.cgColor
        }
    }
    
    fileprivate func setUpViews(model: SSCalendarDay) {
        if getDate(model: model).isMinus() {
            lblName.textColor = configuration.previousDayTextColor
            viewContent.backgroundColor = configuration.previousDayBackgroundColor
            viewContent.layer.borderColor = configuration.previousDayBorderColor.cgColor
        } else {
            lblName.textColor = configuration.upcomingDayTextColor
            viewContent.backgroundColor = configuration.upcomingDayBackgroundColor
            viewContent.layer.borderColor = configuration.upcomingDaysBorderColor.cgColor
        }
        self.setUpTodayLabel(model: model)
        self.manageSelectionColor(model: model)
    }
    
    fileprivate func manageSelectionColor(model: SSCalendarDay) {
        if model.isSelected {
            lblName.textColor = configuration.selectedDayTextColor
            viewContent.backgroundColor = configuration.selectedDayBackGroudColor
            viewContent.layer.borderColor = configuration.selectedDayBorderColor.cgColor
        }
    }
    
    /// Configure Cell
    ///
    /// - Parameter model: Days Model
    func configureCell(model: SSCalendarDay, config: SSCalendarConfiguration) {
        self.configuration = config
        if let day = model.day {
            lblName.text = String(describing: day)
        }
        self.setUpViews(model: model)
    }

}

// MARK: - Days Cell Extension
extension SSDaysCell {
    
    fileprivate func getDate(model: SSCalendarDay) -> Date? {
        return SSCalendarHelper.getDateFrom(year: currentYear, month: currentMonth, day: model.day)
    }
    
}
