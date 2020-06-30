//
//  TardisCalendarPickerViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/28/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisCalendarPickerViewControllerDelegate: class {
    func didSelectPickDate(dates: [String])
}

class TardisCalendarPickerViewController: TardisBasePopupViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var containerView: TardisView!
    @IBOutlet weak var headerView: TardisView!
    @IBOutlet weak var nextButton: TardisButton!
    @IBOutlet weak var previousButton: TardisButton!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var monthDaysCollectionView: UICollectionView!
    
    @IBOutlet weak var heightOfMonthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var actionButtonStackView: UIStackView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    // MARK: - Var
    var day = 1
    var month = 1
    var year = 1
    var weekDay: Weekday = Weekday.Mon
    var selectedIndex = [Int]()
    var selectedDate = [String]()
    weak var delegate: TardisCalendarPickerViewControllerDelegate?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUI()
        reloadData()
        animateView = containerView
    }
    // MARK: - Func
    func setupCollectionView() {
        monthDaysCollectionView.register(UINib(nibName: "TardisCalendarPickerWeekDayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisCalendarPickerWeekDayCollectionViewCell")
        monthDaysCollectionView.register(UINib(nibName: "TardisCalendarPickerDayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisCalendarPickerDayCollectionViewCell")
        monthDaysCollectionView.delegate = self
        monthDaysCollectionView.dataSource = self
    }
    func setupUI() {
        monthTextField.delegate = self
        let currentDay = CommonFunction.getCurrentDay()
        let arrayDate = currentDay.split(separator: "/")
        month = Int(arrayDate[1]) ?? 1
        year = Int(arrayDate[2]) ?? 2020
    }
    func reloadData() {
        selectedIndex.removeAll()
        let firstDayOfCurrentMonth = CommonFunction.getDateFromComponents(day: 1, month: month, year: year)
        monthTextField.text = String(format: "%@ - %04ld", Month.allMonth[month - 1].nameVN,year)
        weekDay = Weekday.allWeekdayWithSunFirst[Calendar.current.component(.weekday, from: firstDayOfCurrentMonth) - 1]
        monthDaysCollectionView.reloadData()
        monthTextField.text = String(format: "%@ - %04ld", Month.allMonth[month - 1].nameVN,year)
    }
    func dateWithIndex(index: Int) -> Date {
        var date = CommonFunction.getDateFromComponents(day: 1, month: month, year: year)
        date = CommonFunction.getDate(fromDate: date,
                                      afterDays: index - weekDay.index)
        return date
    }
    override func hide() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    func getNumberOfDay(inMonth month: String)-> Int {
        let array = month.split(separator: "-")
        guard let month = Int(array[0]) else {return -1}
        guard let year = Int(array[1]) else {return -1}
        if Month.allMonth[month - 1].numberOfDay == -1 {
            return year % 4 == 0 ? 28 : 27
        } else {
            return Month.allMonth[month - 1].numberOfDay
        }
    }
    // MARK: - IBAction
    @IBAction func closeAction(_ sender: Any) {
        hide()
    }
    @IBAction func acceptAction(_ sender: Any) {
        hide()
        guard let delegate = delegate else { return }
        delegate.didSelectPickDate(dates: selectedDate)
    }
    @IBAction func lastMonthAction(_ sender: Any) {
        if month == 1 {
            year -= 1
            month = 12
        } else {
            month -= 1
        }
        reloadData()
    }
    @IBAction func nextMonthAction(_ sender: Any) {
        if month == 12 {
            year += 1
            month = 1
        } else {
            month += 1
        }
        reloadData()
    }
    @IBAction func resetViewAction(_ sender: Any) {
        selectedDate.removeAll()
        monthDaysCollectionView.reloadData()
    }
    
    @IBAction func panGestureRegconized(_ sender: UIPanGestureRecognizer) {
        guard let reconizerView = sender.view else {
            return
        }
        let reconizerLocation = sender.location(in: reconizerView)
        let cellWidth = monthDaysCollectionView.frame.width / 7
        var collum = (reconizerLocation.x / cellWidth)
        var row = ((reconizerLocation.y - cellWidth) / 50)
        collum.round(.down)
        row.round(.down)
        let selected = dateWithIndex(index: Int(collum + row * 7))
        selectedDate.append(CommonFunction.getDateString(fromDate: selected, andFormat: "dd/MM/yyyy"))
        monthDaysCollectionView.reloadData()
    }
}

// MARK: - Extension
extension TardisCalendarPickerViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            if Month.allMonth[month - 1].numberOfDay == -1 {
                return (year % 4 == 0 ? 28 : 27) + weekDay.index
            } else {
                return Month.allMonth[month - 1].numberOfDay + weekDay.index
            }
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisCalendarPickerWeekDayCollectionViewCell", for: indexPath) as? TardisCalendarPickerWeekDayCollectionViewCell {
                cell.bindData(weekDay: Weekday.allWeekdays[indexPath.row])
                return cell
            } else {
                return UICollectionViewCell()
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisCalendarPickerDayCollectionViewCell", for: indexPath) as? TardisCalendarPickerDayCollectionViewCell {
                let date = dateWithIndex(index: indexPath.row)
                cell.isChecked = selectedDate.contains(CommonFunction.getDateString(fromDate: date, andFormat: "dd/MM/yyyy"))
                cell.bindData(date: date,
                              weekDay: Weekday.allWeekdays[indexPath.row % 7],
                              isFromThisMonth: indexPath.row - weekDay.index >= 0)
                return cell
            } else {
                return UICollectionViewCell()
            }
        default:
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return .init(width: monthDaysCollectionView.frame.width / 7 - 10,
                         height: monthDaysCollectionView.frame.width / 7 - 10)
        case 1:
            return .init(width: monthDaysCollectionView.frame.width / 7 - 10,
                         height: 50)
        default:
            return .init(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        heightOfMonthCollectionView.constant = monthDaysCollectionView.contentSize.height
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = dateWithIndex(index: indexPath.row)
        let dateString = CommonFunction.getDateString(fromDate: date, andFormat: "dd/MM/yyyy")
        if indexPath.section == 1 {
            if selectedDate.contains(dateString) {
                selectedDate.remove(at: selectedDate.firstIndex(of: dateString)!)
            } else {
                selectedDate.append(dateString)
            }
            monthDaysCollectionView.reloadData()
        }
    }
}
extension TardisCalendarPickerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        let datePicker = TardisDatePickerViewController()
        datePicker.month = month
        datePicker.year = year
        datePicker.isAutoScrollToCurrentDay = false
        datePicker.pickerKind = .monthYear
        datePicker.delegate = self
        datePicker.show()
    }
}
extension TardisCalendarPickerViewController:TardisDatePickerViewControllerDelegate{
    func selectedDate(day: Int, month: Int, year: Int) {
        self.month = month
        self.year = year
        reloadData()
    }
}
