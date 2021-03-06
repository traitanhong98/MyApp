//
//  TardisScheduleInfoPopup.swift
//  FireBase001
//
//  Created by Hoang on 6/27/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisScheduleInfoPopupDelegate: class {
    func closeAction()
    func deleteAction(withObject object: TardisScheduleObject)
    func acceptAction(withObject object: TardisScheduleObject)
}

class TardisScheduleInfoPopup: TardisBasePopupViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var addCheckListButton: UIButton!
    @IBOutlet weak var containerView: TardisView!
    @IBOutlet weak var nameBlock: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startDayBlock: UIView!
    @IBOutlet weak var startDayTextField: UITextField!
    @IBOutlet weak var endDayBlock: UIView!
    @IBOutlet weak var endDayTextField: UITextField!
    
    @IBOutlet weak var timeBlock: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    @IBOutlet weak var heightOfCheckListView: NSLayoutConstraint!
    @IBOutlet weak var tagBlock: UIView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var desBlock: UIView!
    @IBOutlet weak var desTextView: UITextField!
    @IBOutlet weak var checkListBlock: UIView!
    @IBOutlet weak var checkListTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    // MARK: - Propety
    weak var delegate: TardisScheduleInfoPopupDelegate?
    var schedule = TardisScheduleObject()
    var activeField: UITextField?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animateView = containerView
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = schedule.name
        startDayTextField.text = schedule.startDay
        endDayTextField.text = schedule.endDay
        startTimeTextField.text = schedule.startTime
        endTimeTextField.text = schedule.endTime
        tagTextField.text = schedule.tag
        desTextView.text = schedule.des
        checkListTableView.reloadData()
    }
    func bindData(schedule: TardisScheduleObject) {
        self.schedule = schedule
    }
    func setupUI() {
        checkListTableView.register(UINib(nibName: "TardisScheduleInfoPopupTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: "TardisScheduleInfoPopupTableViewCell")
        nameTextField.delegate = self
        checkListTableView.delegate = self
        checkListTableView.dataSource = self
        startDayTextField.delegate = self
        endDayTextField.delegate = self
        startTimeTextField.delegate = self
        tagTextField.delegate = self
        endTimeTextField.delegate = self
        desTextView.delegate = self
        desTextView.accessibilityScroll(.down)
    }
    func showCalendarPicker(onTextField textField: UITextField) {
        let calendarPicker = TardisCalendarPickerViewController()
        if textField == startDayTextField {
            calendarPicker.recognizeID = "startDay"
        } else {
            calendarPicker.recognizeID = "endDay"
        }
        calendarPicker.delegate = self
        calendarPicker.show()
    }
    func showTimePicker(onTextField textField: UITextField) {
        let timePicker = TardisTimePickerViewController()
        if textField == startTimeTextField {
            timePicker.recognizeID = "startTime"
        } else  {
            timePicker.recognizeID = "endTime"
        }
        timePicker.delegate = self
        timePicker.show()
    }
    // MARK: - IBAction
    @IBAction func closeAction(_ sender: Any) {
        hide()
    }
    @IBAction func deleteAction(_ sender: Any) {
        hide()
        guard let delegate = delegate else { return }
        delegate.deleteAction(withObject: schedule)
    }
    @IBAction func addCheckListAction(_ sender: Any) {
        let addPopup = TardisActivityAddCheckListPopup()
        addPopup.delegate = self
        addPopup.show()
    }
    @IBAction func acceptAction(_ sender: Any) {
        hide()
        guard let delegate = delegate else { return }
        schedule.name = nameTextField.text ?? ""
        schedule.startDay = startDayTextField.text ?? ""
        schedule.endDay = endDayTextField.text ?? ""
        schedule.startTime = startTimeTextField.text ?? ""
        schedule.endTime = endTimeTextField.text ?? ""
        schedule.des = desTextView.text ?? ""
        delegate.acceptAction(withObject: schedule)
    }
}
// MARK: - UITableViewDelegate
extension TardisScheduleInfoPopup: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.checkList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = checkListTableView.dequeueReusableCell(withIdentifier: "TardisScheduleInfoPopupTableViewCell", for: indexPath)
            as? TardisScheduleInfoPopupTableViewCell else { return UITableViewCell() }
        cell.bindData(checkListObject: schedule.checkList[indexPath.row], atIndexPath: indexPath)
        cell.delegate = self
        cell.desTextField.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.contentSize.height > 150 {
            heightOfCheckListView.constant = 150
        } else {
            heightOfCheckListView.constant = tableView.contentSize.height
        }
    }
}
// MARK: - UITextFieldDelegate
extension TardisScheduleInfoPopup: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var isFromTableView = true
        for view in self.view.subviews
            where view == textField {
                isFromTableView = false
                break
        }
        if isFromTableView {
            self.view.frame = .init(x: 0,
                                    y: 0,
                                    width: self.view.frame.width,
                                    height: self.view.frame.height)
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == startDayTextField || textField == endDayTextField {
            showCalendarPicker(onTextField: textField)
            return false
        } else if textField == startTimeTextField || textField == endTimeTextField {
            showTimePicker(onTextField: textField)
            return false
        }
        return true
    }
}
extension TardisScheduleInfoPopup: TardisScheduleInfoPopupTableViewCellDelegate {
    func check(inCheckListObject object: TardisCheckListObject, atIndexPath indexPath: IndexPath) {
        schedule.checkList[indexPath.row] = object
    }
    func delete(checkListObject object: TardisCheckListObject, atIndexPath indexPath: IndexPath) {
        schedule.checkList.remove(at: indexPath.row)
        checkListTableView.reloadData()
    }
}
// MARK: - UITextViewDelegate
extension TardisScheduleInfoPopup: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
extension TardisScheduleInfoPopup: TardisTimePickerViewControllerDelegate {
    func selectedTime(time: String, recognizeID: String) {
        switch recognizeID {
        case "startTime":
            startTimeTextField.text = time
        case "endTime":
            endTimeTextField.text = time
        default:
            break
        }
    }
}
extension TardisScheduleInfoPopup: TardisCalendarPickerViewControllerDelegate {
    func didSelectPickDate(dates: [String], recognizeID: String) {
        if dates.count >= 2 {
            startDayTextField.text = dates[0]
            endDayTextField.text = dates.last ?? ""
        } else {
            guard dates.count > 0 else {
                return
            }
            switch recognizeID {
            case "startDay":
                startDayTextField.text = dates[0]
            case "endDay":
                endDayTextField.text = dates[0]
            default:
                break
            }
        }
    }
}
extension TardisScheduleInfoPopup: TardisActivityAddCheckListPopupDelegate {
    func acceptAction(checkList: [TardisCheckListObject]) {
        schedule.checkList += checkList
        checkListTableView.reloadData()
    }
}
