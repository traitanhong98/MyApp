//
//  TardisTimePickerViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisTimePickerViewControllerDelegate: class {
    func selectedTime(time: String)
}

class TardisTimePickerViewController: UIViewController {
    // MARK: - Propety
    weak var delegate: TardisTimePickerViewControllerDelegate?
    var minute = 0
    var hour = 0
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        pickerView.selectRow(hour, inComponent: 0, animated: true)
        pickerView.selectRow(minute, inComponent: 1, animated: true)
    }
    func show() {
        self.view.frame = CommonFunction.rootVC.view.frame
        self.view.isUserInteractionEnabled = true
        CommonFunction.rootVC.addChild(self)
        CommonFunction.rootVC.view.addSubview(self.view)
        CommonFunction.rootVC.view.bringSubviewToFront(self.view)
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
        delegate.selectedTime(time: "\(hour):\(minute)")
    }
}
extension TardisTimePickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let width = pickerView.frame.size.width
        return width / 2
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard var label = view as? UILabel? else {
            return UIView()
        }
        if label == nil {
            label = UILabel()
        }
        label?.text = "\(row + 1)"
        label?.textAlignment = .center
        return label ?? UIView()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minute = row
        default:
            break
        }
    }
}
