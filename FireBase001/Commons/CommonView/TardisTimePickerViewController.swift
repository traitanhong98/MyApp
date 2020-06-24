//
//  TardisTimePickerViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisTimePickerViewControllerDelegate: class {
    func selectedTime(time: String,recognizeID: String)
}

class TardisTimePickerViewController: UIViewController {
    // MARK: - Propety
    weak var delegate: TardisTimePickerViewControllerDelegate?
    var minute = 0
    var hour = 0
    var recognizeID = ""
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Func
    func setupData() {
        let currentTime = CommonFunction.getCurrenTime()
        let arrayTime = currentTime.split(separator: ":")
        hour = Int(arrayTime[0]) ?? 0
        minute = Int(arrayTime[1]) ?? 0
    }
    func showPickerView() {
        let pickerView = UIPickerView.init(frame: .init(x: 0,
                                                        y: self.view.frame.height - 150,
                                                        width: self.view.frame.width,
                                                        height: 150))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        self.view.bringSubviewToFront(pickerView)
        pickerView.selectRow(hour , inComponent: 0, animated: true)
        pickerView.selectRow(minute, inComponent: 2, animated: true)
    }
    func show() {
        self.view.frame = CommonFunction.rootVC.view.frame
        self.view.isUserInteractionEnabled = true
        CommonFunction.rootVC.addChild(self)
        CommonFunction.rootVC.view.addSubview(self.view)
        self.view.layoutIfNeeded()
        showPickerView()
    }
    func hide() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    // MARK: - IBAction
    
    @IBAction func backAction(_ sender: Any) {
        self.hide()
    }
    @IBAction func finishAction(_ sender: Any) {
        guard let delegate =  delegate else {return}
        var timeString = ""
        if hour < 10 {
            timeString = timeString + "0\(hour)"
        } else {
            timeString = "\(hour)"
        }
        if minute < 10 {
            timeString = timeString + ":0\(minute)"
        } else {
            timeString = timeString + ":\(minute)"
        }
        delegate.selectedTime(time: timeString,recognizeID: recognizeID)
        self.hide()
    }
}
extension TardisTimePickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 1
        case 2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard var label = view as? UILabel? else {
            return UIView()
        }
        if label == nil {
            label = UILabel()
        }
        label?.font = UIFont(name: "Noteworthy", size: 20)
        if component != 1 {
            if row < 10 {
                label?.text = "0\(row)"
            } else {
                label?.text = "\(row)"
            }
        } else {
            label?.text = ":"
        }
        label?.textAlignment = .center
        return label ?? UIView()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 2:
            minute = row
        default:
            break
        }
    }
}
