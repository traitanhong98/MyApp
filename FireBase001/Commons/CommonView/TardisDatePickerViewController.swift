//
//  TardisDatePickerViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/20/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisDatePickerViewControllerDelegate: class {
    func selectedDate(date: String)
}
class TardisDatePickerViewController: UIViewController {
    
    // MARK: - IBOutlet
    // MARK: - Propety
    weak var delegate: TardisDatePickerViewControllerDelegate?
    let maxYear = 2099
    let minYear = 1990
    
    var day = 0
    var month = 0
    var year = 2020
    var currentDay = ""
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }


    // MARK: - Func
    func setupData() {
        
        currentDay = CommonFunction.getCurrentDay()
        let arrayDate = currentDay.split(separator: "/")
        day = Int(arrayDate[0]) ?? 1
        month = Int(arrayDate[1]) ?? 1
        year = Int(arrayDate[2]) ?? 2020
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
        pickerView.selectRow(day - 1, inComponent: 0, animated: true)
        pickerView.selectRow(month - 1, inComponent: 1, animated: true)
        pickerView.selectRow(year - minYear, inComponent: 2, animated: true)
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
        guard let delegate = delegate else { return }
        delegate.selectedDate(date: "\(day)/\(month)/\(year)")
        self.hide()
    }
    
}
extension TardisDatePickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            if Month.allMonth[month - 1].numberOfDay == -1 {
                return year % 4 == 0 ? 28 : 27
            } else {
                return Month.allMonth[month - 1].numberOfDay
            }
        case 1:
            return 12
        case 2:
            return maxYear - minYear
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let width = pickerView.frame.size.width
        return width / 3
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard var label = view as? UILabel? else {
            return UIView()
        }
        if label == nil {
            label = UILabel()
        }
        
        switch component {
        case 0:
            label?.text = "\(row + 1)"
            break
        case 1:
            label?.text = Month.allMonth[row].nameVN
            break
        case 2:
            label?.text = "\(row + minYear)"
            break
        default:
            break
        }
        label?.textAlignment = .center
        return label ?? UIView()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            day = row + 1
        case 1:
            month = row + 1
            pickerView.reloadComponent(0)
        case 2:
            year = row + minYear
            pickerView.reloadComponent(0)
        default:
            break
        }
    }
}
