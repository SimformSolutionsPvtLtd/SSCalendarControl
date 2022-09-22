//
//  CalendarView.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 11/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

/// Calendar Delegates
public protocol SSCalendarDeleagte: class {
    func dateSelected(_ date: Date)
    func dateDeSelected(_ date: Date)
}

/// Calendar View
public class SSCalendarView: UIView, SSNibLoadable {
    
    // MARK:- Outlet
    @IBOutlet weak var cvMonths: UICollectionView!
    
    // MARK:- Variables
    public weak var delegate: SSCalendarDeleagte?
    private var startingDate = SSConstants.todayDate
    private var endingDate = SSConstants.todayDate.getDateAfter(years: 1, months: 0)
    private var monthModels = [SSCalendarMonth]()
    private var totalMonths: Int!
    private var weekStartDay = WeekStartDay.monday
    private var selectPastDays = false
    private var multipleSelection = true
    
    private var currentSelectedMonthIndex: IndexPath?
    
    // MARK:- Constatnts
    fileprivate let monthCellID = "MonthCell"
    fileprivate let headerViewID = "HeaderView"
    
    /// Calendar view configration
    var configuration = SSCalendarConfiguration()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ssFromNib()
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ssFromNib()
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        setUpCalendar()
        setUpCollection()
    }
    
    fileprivate func createDataModel(startMonth: (month: Int, year: Int, name: String), endMonth: (month: Int, year: Int, name: String)) {
        monthModels = [SSCalendarMonth]()
        var startDate = startingDate
        let endDate = endingDate
        while startDate <= endDate {
            let month = startDate.getMonth()
            self.monthModels.append(SSCalendarMonth(monthNo: month.month, month: month.name, year: month.year))
            startDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        }
        DispatchQueue.main.async { [weak self] in
            self?.cvMonths.reloadData()
        }
    }
    
    fileprivate func setUpCollection() {
        cvMonths.delegate = self
        cvMonths.dataSource = self
        cvMonths.allowsSelection = false
        let bundle = Bundle(for: type(of: self))
        cvMonths.register(UINib(nibName: "\(SSMonthCell.self)", bundle: bundle), forCellWithReuseIdentifier: monthCellID)
        cvMonths.register(UINib(nibName: "\(SSHeaderView.self)", bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewID)
        if let layout = cvMonths.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    /// Setup method for calendar view
    ///
    /// - Parameters:
    ///   - startDate: Starting date
    ///   - endDate: Ending Date
    ///   - weekStartDay: Week start day
    ///   - selectPastDays: Allow to select past day
    ///   - multipleSelectable: Allow select multiple dates
    public func setUpCalendar(startDate: Date = SSConstants.todayDate, endDate: Date = SSConstants.todayDate.getDateAfter(years: 1, months: 0), weekStartDay: WeekStartDay = .monday, shouldSelectPastDays: Bool = false, sholudAllowMultipleSelection: Bool = true) {
        self.startingDate = startDate
        self.endingDate = endDate
        self.weekStartDay = weekStartDay
        self.selectPastDays = shouldSelectPastDays
        self.multipleSelection = sholudAllowMultipleSelection
        let startMonth = startingDate.getMonth()
        let endMonth = endingDate.getMonth()
        createDataModel(startMonth: startMonth, endMonth: endMonth)
    }
    
}

// MARK:- CalendarView Extension
extension SSCalendarView {
    
    fileprivate func getTotalNumberOfItems(model: SSCalendarMonth) -> Int {
        let days = getNumberOfDays(year: model.year, month: model.monthNo)
        let weekDay = SSCalendarHelper.getDayOfWeekFrom(year: model.year, month: model.monthNo)
        let skipCount = getSkeepCount(weekDay, startDay: self.weekStartDay)
        return days + skipCount
    }
    
    fileprivate func getCollectionHeight(for indexPath: IndexPath) -> CGFloat {
        let model = monthModels[indexPath.row]
        let totalDays = getTotalNumberOfItems(model: model)
        let factor = (frame.width / 7)
        let height: CGFloat = CGFloat(ceil(Double(totalDays)/7.0)) * factor
        return height
    }
    
}

// MARK:- UICollectionViewDataSource
extension SSCalendarView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModels.count
    }
    
    fileprivate func postConfigureItem(for cell: SSMonthCell, with indexPath: IndexPath) {
        cell.postConfigurationSetup(weekStartDay: self.weekStartDay, shouldSelectPastDays: self.selectPastDays, allowsMultipleSelection: self.multipleSelection, delegate: delegate)
        cell.monthDelegate = self
        cell.collectionIndexPath = indexPath
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthCellID, for: indexPath) as? SSMonthCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: self.monthModels[indexPath.row], config: configuration)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let uSelf = self else {
                return
            }
            uSelf.postConfigureItem(for: cell, with: indexPath)
        }
        return cell
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout
extension SSCalendarView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getCollectionHeight(for: indexPath)
        return CGSize(width: frame.width - 12, height: height + 70)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: cvMonths.bounds.width, height: 50)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as? SSHeaderView else {
                return UICollectionReusableView()
            }
            headerView.weekStartDay = self.weekStartDay
            headerView.configuration = configuration
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
}

// MARK: - This delegates are only for handle single selection
extension SSCalendarView: MonthCellDelegate {
    
    func deselectItem(at indexPath: IndexPath) {
        if let currentSelectedMonth = currentSelectedMonthIndex, currentSelectedMonth != indexPath {
            for model in self.monthModels[currentSelectedMonth.row].days {
                model.isSelected = false
            }
            if let cell = self.cvMonths.cellForItem(at: currentSelectedMonth) as? SSMonthCell {
                /// call method of month cell
                cell.reloadDataFromCalenderView()
            }
        }
        currentSelectedMonthIndex = indexPath
    }

}
