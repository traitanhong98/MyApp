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
    func deleteAcvitity(activity: TardisActivityObject)
}


class TardisAddNewActivityPopup: TardisBasePopupViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var contentView: TardisView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    
    @IBOutlet weak var adviceBlock: UIView!
    @IBOutlet weak var noteTextField: TardisTextView!
    
    @IBOutlet weak var weekdayButtonCollectionView: UICollectionView!
    @IBOutlet weak var backButton: TardisButton!
    @IBOutlet weak var enableNotificationButton: TardisButton!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var deleteActivityButton: TardisButton!
    @IBOutlet weak var addButton: TardisButton!
    // MARK: - Propety
    weak var delegate: TardisAddNewActivityPopupDelegate?
    var weekdayButtonCollectionViewFlowLayout: UICollectionViewFlowLayout?
    var arrayWeekDay = [Weekday]()
    let dataModel = TardisActivitiesDataModel.shared
    var activity = TardisActivityObject()
    var isAllowAddActivity = true
    var isHiddenDeleteButton = false
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindData()
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
        nameTextField.delegate = self
        containerView.sendSubviewToBack(closeButton)
        deleteActivityButton.isHidden = isHiddenDeleteButton
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
    func bindData() {
        nameTextField.text = activity.activityName
        startTimeTextField.text = activity.startTime
        endTimeTextField.text = activity.endTime
        noteTextField.text = activity.note
        let arrayWeek = activity.loopDay.split(separator: " ")
        for weekDay in arrayWeek {
            arrayWeekDay.append(Weekday.allWeekdays[Int(weekDay) ?? 0])
        }
        weekdayButtonCollectionView.reloadData()
        statusNotificationButton()
    }
    func showTimePicker(id: String) {
        let timePicker = TardisTimePickerViewController()
        timePicker.delegate = self
        timePicker.recognizeID = id
        timePicker.show()
    }
    func statusNotificationButton() {
        if activity.isNotificaion {
            enableNotificationButton.tintColor = mainColor
        } else {
            enableNotificationButton.tintColor = .gray
        }
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
    func doAdvice(time: String) {
        if CommonFunction.getMinute(fromTime: time) > CommonFunction.getMinute(fromTime: "22:00") {
            adviceBlock.isHidden = false
            adviceLabel.text = "Bạn không nên thức quá muộn"
        } else {
            adviceBlock.isHidden = true
        }
    }
    func checkValidActivity() -> Bool {
        guard let start = startTimeTextField.text, let end = endTimeTextField.text else {return false}
        for day in arrayWeekDay {
            for activity in dataModel.dailyActivityArray[day.index] {
                if start < activity.startTime && activity.startTime < end {
                    adviceLabel.text = "Bạn đã có lịch \" \(activity.activityName)\" rồi"
                    adviceBlock.isHidden = false
                    isAllowAddActivity = false
                    return false
                }
                if start < activity.endTime && activity.endTime < end {
                    adviceLabel.text = "Bạn đã có lịch \" \(activity.activityName)\" rồi"
                    adviceBlock.isHidden = false
                    isAllowAddActivity = false
                    return false
                }
            }
        }
        adviceBlock.isHidden = true
        isAllowAddActivity = true
        return true
    }
    func checkValidActivity(weekDay:Weekday)->Bool {
        guard let start = startTimeTextField.text, let end = endTimeTextField.text else {return false}
        for activity in dataModel.dailyActivityArray[weekDay.index] {
            if start < activity.startTime && activity.startTime < end {
                adviceLabel.text = "* Bạn đã có lịch \" \(activity.activityName)\" rồi"
                adviceBlock.isHidden = false
                isAllowAddActivity = false
                return false
            }
            if start < activity.endTime && activity.endTime < end {
                adviceLabel.text = "* Bạn đã có lịch \" \(activity.activityName)\" rồi"
                adviceBlock.isHidden = false
                isAllowAddActivity = false
                return false
            }
            if activity.startTime < start && start < activity.endTime {
                adviceLabel.text = "* Bạn đã có lịch \" \(activity.activityName)\" rồi"
                adviceBlock.isHidden = false
                isAllowAddActivity = false
                return false
            }
            if activity.startTime < end && end < activity.endTime {
                adviceLabel.text = "* Bạn đã có lịch \" \(activity.activityName)\" rồi"
                adviceBlock.isHidden = false
                isAllowAddActivity = false
                return false
            }
        }
        adviceBlock.isHidden = true
        isAllowAddActivity = true
        return true
    }
    // MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        self.hide()
    }
    @IBAction func doneAction(_ sender: Any) {
        if !checkValidTime() {
            CommonFunction.annoucement(title: "", message: "Thời gian không hợp lệ")
            isAllowAddActivity = false
            return
        }
        if !checkValidActivity() {
            CommonFunction.annoucement(title: "", message: "Thời gian không hợp lệ")
            isAllowAddActivity = false
            return
        }
        if arrayWeekDay.count == 0 {
            CommonFunction.annoucement(title: "", message: "Bạn chưa chọn ngày")
            isAllowAddActivity = false
            return
        }
        if !isAllowAddActivity {
            return
        }
        activity.activityName = nameTextField.text ?? ""
        activity.startTime = startTimeTextField.text ?? ""
        activity.endTime = endTimeTextField.text ?? ""
        activity.note = noteTextField.text ?? ""
        var loopDay = ""
        for day in arrayWeekDay {
            loopDay += "\(day.index) "
        }
        activity.loopDay = loopDay
        guard let delegate = delegate else { return }
        delegate.addActivity(activity: activity)
        self.hide()
    }
    @IBAction func notificationAction(_ sender: Any) {
        activity.isNotificaion = !activity.isNotificaion
        statusNotificationButton()
    }
    @IBAction func deleteAction(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.deleteAcvitity(activity: activity)
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
            cell.isChecked = arrayWeekDay.contains(Weekday.allWeekdays[indexPath.section])
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
            view.endEditing(true)
            showTimePicker(id: "startTime")
            break
        case endTimeTextField:
            view.endEditing(true)
            showTimePicker(id: "endTime")
            break
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
// MARK: - TardisTimePickerViewControllerDelegate
extension TardisAddNewActivityPopup:TardisTimePickerViewControllerDelegate {
    func selectedTime(time: String, recognizeID: String) {
        switch recognizeID {
        case "startTime":
            startTimeTextField.text = time
            if !checkValidTime() {
                isAllowAddActivity = false
                startTimeTextField.textColor = UIColor.red
            } else {
                isAllowAddActivity = true
                startTimeTextField.textColor = .init(red: 0 / 255, green: 37 / 255, blue: 77 / 255, alpha: 1)
                endTimeTextField.textColor = .init(red: 0 / 255, green: 37 / 255, blue: 77 / 255, alpha: 1)
            }
            break
        case "endTime":
            endTimeTextField.text = time
            if !checkValidTime() {
                isAllowAddActivity = false
                endTimeTextField.textColor = UIColor.red
            } else {
                isAllowAddActivity = true
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
                isAllowAddActivity = checkValidActivity()
            }
        }
    }
}
