//
//  TardisAddNewActivityPopup.swift
//  FireBase001
//
//  Created by Hoang on 6/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit


protocol TardisAddNewActivityPopupDelegate: class {
    func addActivity(activity: TardisActivityObject)
}


class TardisAddNewActivityPopup: TardisBasePopupViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var contentView: TardisView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    
    @IBOutlet weak var noteTextField: TardisTextView!
    
    @IBOutlet weak var weekdayButtonCollectionView: UICollectionView!
    @IBOutlet weak var backButton: TardisButton!
    @IBOutlet weak var enableNotificationButton: TardisButton!
    @IBOutlet weak var addButton: TardisButton!
    // MARK: - Propety
    weak var delegate: TardisAddNewActivityPopupDelegate?
    var weekdayButtonCollectionViewFlowLayout: UICollectionViewFlowLayout?
    var arrayWeekDay = [Weekday]()
    let dataModel = TardisActivitiesDataModel.shared
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setupCollectionView()
    }
    // MARK: - Func
    func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        self.animateView = containerView
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
        containerView.sendSubviewToBack(closeButton)
        
    }
    func setupCollectionView() {
        weekdayButtonCollectionView.clipsToBounds = true
        weekdayButtonCollectionView.layer.masksToBounds = true
        weekdayButtonCollectionView.register(UINib(nibName: "TardisActivityPopupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisActivityPopupCollectionViewCell")
        let weekdayButtonCollectionViewFlowLayout = weekdayButtonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        weekdayButtonCollectionViewFlowLayout.itemSize = .init(
            width: weekdayButtonCollectionView.frame.width / 7,
            height: weekdayButtonCollectionView.frame.width / 7)
        weekdayButtonCollectionViewFlowLayout.scrollDirection = .horizontal
        initLayoutForCollectionView(weekdayButtonCollectionView)
    }
    func initLayoutForCollectionView(_ collectionView: UICollectionView){
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    func showTimePicker(id: String) {
        let timePicker = TardisTimePickerViewController()
        timePicker.delegate = self
        timePicker.recognizeID = id
        timePicker.show()
    }
    func checkValidTime() -> Bool {
        guard let startTime = startTimeTextField.text , let endTime = endTimeTextField.text else {
            return false
        }
        if startTime >= endTime {
            return false
        }
        return true
    }
    func checkValidActivity() -> Bool {
        guard let start = startTimeTextField.text, let end = endTimeTextField.text else {return false}
        for day in arrayWeekDay {
            for activity in dataModel.dailyActivityArray[day.index] {
                if start < activity.startTime && activity.startTime < end {
                    return false
                }
                if start < activity.endTime && activity.endTime < end {
                    return false
                }
            }
        }
        return true
    }
    func checkValidActivity(weekDay:Weekday)->Bool {
        guard let start = startTimeTextField.text, let end = endTimeTextField.text else {return false}
        for activity in dataModel.dailyActivityArray[weekDay.index] {
            if start < activity.startTime && activity.startTime < end {
                return false
            }
            if start < activity.endTime && activity.endTime < end {
                return false
            }
            if activity.startTime < start && start < activity.endTime {
                return false
            }
            if activity.startTime < end && end < activity.endTime {
                return false
            }
        }
        return true
    }
    // MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        self.hide()
    }
    @IBAction func doneAction(_ sender: Any) {
        if !checkValidTime() {
            CommonFunction.annoucement(title: "", message: "Thời gian không hợp lệ")
            return
        }
        if !checkValidActivity() {
            CommonFunction.annoucement(title: "", message: "Thời gian không hợp lệ")
        }
        if arrayWeekDay.count == 0 {
            CommonFunction.annoucement(title: "", message: "Bạn chưa chọn ngày")
        }
        let activity = TardisActivityObject.init(activityName: nameTextField.text ?? "",
                                                 startTime: startTimeTextField.text ?? "",
                                                 endTime: endTimeTextField.text ?? "",
                                                 note: noteTextField.text ?? "",
                                                 location: "")
        var loopDay = ""
        for day in arrayWeekDay {
            loopDay += "\(day.index) "
        }
        activity.loopDay = loopDay
        guard let delegate = delegate else { return }
        delegate.addActivity(activity: activity)
        self.hide()
    }
}
// MARK: - UICollectionViewDelegate
extension TardisAddNewActivityPopup:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisActivityPopupCollectionViewCell", for: indexPath) as? TardisActivityPopupCollectionViewCell {
            cell.bindData(weekDay: Weekday.allWeekdays[indexPath.section])
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
// MARK: - UITextFieldDelegate
extension TardisAddNewActivityPopup:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case startTimeTextField:
            showTimePicker(id: "startTime")
            view.endEditing(true)
            break
        case endTimeTextField:
            showTimePicker(id: "endTime")
            
            view.endEditing(true)
            break
        default:
            break
        }
    }
}
// MARK: - TardisTimePickerViewControllerDelegate
extension TardisAddNewActivityPopup:TardisTimePickerViewControllerDelegate {
    func selectedTime(time: String, recognizeID: String) {
        switch recognizeID {
        case "startTime":
            startTimeTextField.text = time
            if !checkValidTime() {
                startTimeTextField.textColor = UIColor.red
            } else {
                startTimeTextField.textColor = .init(red: 0 / 255, green: 37 / 255, blue: 77 / 255, alpha: 1)
                endTimeTextField.textColor = .init(red: 0 / 255, green: 37 / 255, blue: 77 / 255, alpha: 1)
            }
            break
        case "endTime":
            endTimeTextField.text = time
            if !checkValidTime() {
                endTimeTextField.textColor = UIColor.red
            } else {
                endTimeTextField.textColor = .init(red: 0 / 255, green: 37 / 255, blue: 77 / 255, alpha: 1)
                startTimeTextField.textColor = .init(red: 0 / 255, green: 37 / 255, blue: 77 / 255, alpha: 1)
            }
            break
        default:
            break
        }
    }
    
    
}
// MARK: - TardisActivityPopupCollectionViewCellDelegate
extension TardisAddNewActivityPopup:TardisActivityPopupCollectionViewCellDelegate {
    func didSelect(weekDay: Weekday, isChecked: Bool, completionBlock: @escaping (Bool) -> Void) {
        if isChecked {
            completionBlock(checkValidActivity(weekDay: weekDay))
            arrayWeekDay.append(weekDay)
        } else {
            if let index = arrayWeekDay.firstIndex(of: weekDay) {
                arrayWeekDay.remove(at: index)
            }
        }
    }
}