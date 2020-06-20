//
//  TardisDatePickerView.swift
//  FireBase001
//
//  Created by Hoang on 6/20/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisDatePickerView: UIView {
    let maxYear = 2099
    let minYear = 1990
    
    var day = 1
    var month = 1
    var year = 2020
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        let pickerView = UIPickerView.init(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: self.frame.width,
                                                     height: self.frame.height))
        pickerView.delegate = self
        pickerView.dataSource = self
        self.addSubview(pickerView)
    }
}

extension TardisDatePickerView: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            if Month.allMonth[month].numberOfDay == -1 {
                return year % 4 == 0 ? 28 : 27
            } else {
                return Month.allMonth[month].numberOfDay
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
        case 1:
            label?.text = "\(row + 1)"
            break
        case 2:
            label?.text = Month.allMonth[row].nameVN
            break
        case 3:
            label?.text = "\(row + minYear)"
            break
        default:
            break
        }
        return label ?? UIView()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            day = row + 1
        case 1:
            month = row + 1
        case 2:
            year = row + minYear
        default:
            break
        }
    }
}
