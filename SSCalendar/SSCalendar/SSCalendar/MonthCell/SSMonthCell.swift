//
//  MonthCell.swift
//  CalendarControll
//
//  Created by Ketan Chopda on 10/01/19.
//  Copyright © 2019 Simform solution. All rights reserved.
//

import UIKit

protocol MonthCellDelegate: class {
    func deselectItem(at indexPath: IndexPath)
}

/// Month Cell
class SSMonthCell: UICollectionViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var cvDays: UICollectionView!
    @IBOutlet weak var lblMonthDesc: UILabel!
    @IBOutlet weak var viewMonthContent: UIView!
    @IBOutlet weak var viewBottomLine: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    // MARK:- Variables
    weak var delegate: SSCalendarDeleagte?
    weak var monthDelegate: MonthCellDelegate?
    
    var currentMonth = 1
    var year = 2019
    var monthName: String = ""
    var monthDaysCount = 0
    var skipCount = 0
    var weekStartDay = WeekStartDay.monday
    var shouldSelectPastDays = false
    var allowsMultipleSelection = true
    var monthModel: SSCalendarMonth?
    
    var previousIndex: IndexPath?
    var collectionIndexPath: IndexPath?
    var configuration = SSCalendarConfiguration()
    
    // MARK:- Constants
    let daysCellID = "DaysCell"
    let emptyDayCellID = "EmptyDayCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetUp()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupViews()
    }
    
    fileprivate func setupViews() {
        lblMonthDesc.font = configuration.monthLabelFont
        lblMonthDesc.textColor = configuration.monthLabelTextColor
        viewBottomLine.backgroundColor = configuration.monthViewBottomLineColor
        viewContent.backgroundColor = configuration.monthViewBackgroundColor
    }
    
    fileprivate func initialSetUp() {
        cvDays.dataSource = self
        cvDays.delegate = self
        let bundle = Bundle(for: type(of: self))
        cvDays.register(UINib(nibName: "\(SSDaysCell.self)", bundle: bundle), forCellWithReuseIdentifier: daysCellID)
        cvDays.register(UINib(nibName: "\(SSEmptyDayCell.self)", bundle: bundle), forCellWithReuseIdentifier: emptyDayCellID)
    }
    
    fileprivate func loadCollection() {
        monthDaysCount = getNumberOfDays(year: year, month: currentMonth)
        let weekDayNo = SSCalendarHelper.getDayOfWeekFrom(year: year, month: currentMonth)
        skipCount = getSkeepCount(weekDayNo, startDay: weekStartDay)
        cvDays.allowsMultipleSelection = allowsMultipleSelection
        DispatchQueue.main.async { [weak self] in
            self?.cvDays.reloadData()
        }
    }
    
    func configureCell(model: SSCalendarMonth, config: SSCalendarConfiguration) {
        self.configuration = config
        self.monthModel = model
        self.currentMonth = model.monthNo
        self.monthName = model.month
        self.year = model.year
        self.lblMonthDesc.text = monthName + " " + "\(year)"
        loadCollection()
    }
    
    func postConfigurationSetup(weekStartDay: WeekStartDay, shouldSelectPastDays: Bool, allowsMultipleSelection: Bool, delegate: SSCalendarDeleagte?) {
        self.weekStartDay = weekStartDay
        self.shouldSelectPastDays = shouldSelectPastDays
        self.allowsMultipleSelection = allowsMultipleSelection
        self.delegate = delegate
    }

}

// MARK: - UICollectionViewDataSource
extension SSMonthCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = monthModel {
            return model.days.count + skipCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < skipCount {
            return collectionView.dequeueReusableCell(withReuseIdentifier: emptyDayCellID, for: indexPath)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: daysCellID, for: indexPath) as? SSDaysCell else {
            return UICollectionViewCell()
        }
        
        cell.monthIndexPath = collectionIndexPath
        cell.currentMonth = self.currentMonth
        cell.currentYear = self.year
        
        if let model = self.monthModel {
            cell.configureCell(model: model.days[indexPath.row - skipCount], config: configuration)
        }

        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SSMonthCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cvDays.frame.width / 7
        let contentSize = CGSize(width: width, height: width)
        return contentSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - UICollectionViewDelegate
extension SSMonthCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK:- This is actually manages selection and deselection of cell
        manageSelection(indexPath)
    }
    
}

// MARK: - MonthCell extension
extension SSMonthCell {

    fileprivate func manageSelection(_ indexPath: IndexPath) {
        guard let model = self.monthModel?.days[indexPath.row - skipCount] else {
            return
        }
        guard let date = SSCalendarHelper.getDateFrom(year: year, month: currentMonth, day: model.day) else { return }
        if date.isMinus(), !shouldSelectPastDays {
            return
        }
        handleDateSelection(with: model, date: date, indexPath: indexPath)
    }
    
    fileprivate func deselectAllPreviousCell(_ indexPath: IndexPath) {
        // MARK:- This is to manage previous cell selection within same month
        if let previousIndex = previousIndex, previousIndex != indexPath {
            guard let days = monthModel?.days else { return }
            _ = days.map { $0.isSelected = false }
            cvDays.reloadData()
        }
        self.previousIndex = indexPath
    }
    
    fileprivate func handleDateSelection(with model: SSCalendarDay, date: Date, indexPath: IndexPath) {
        if !allowsMultipleSelection {
            self.deselectAllPreviousCell(indexPath)
        }
        model.isSelected.toggle()
        cvDays.reloadItems(at: [indexPath])
        if model.isSelected {
            selectDate(date)
        } else {
            deSelectDate(date)
        }
        if !allowsMultipleSelection {
            self.managePreviousSelection(indexPath, model: model)
        }
    }
    
    fileprivate func managePreviousSelection(_ indexPath: IndexPath, model: SSCalendarDay) {
        // MARK:- This is to manage previous cell selection in whole calendar controll
        if let collectionIndexPath = collectionIndexPath, !allowsMultipleSelection {
            monthDelegate?.deselectItem(at: collectionIndexPath)
        }
    }
    
    fileprivate func deSelectDate(_ date: Date) {
        delegate?.dateDeSelected(date)
    }
    
    fileprivate func selectDate(_ date: Date) {
        delegate?.dateSelected(date)
    }
    
}

// MARK: - This is only for handle single selection
extension SSMonthCell {
    
    func reloadDataFromCalenderView() {
        DispatchQueue.main.async { [weak self] in
            guard let uSelf = self else {
                return
            }
            uSelf.cvDays.reloadData()
        }
    }
    
}
