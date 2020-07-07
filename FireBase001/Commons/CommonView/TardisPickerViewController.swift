//
//  TardisPickerViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/7/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

protocol TardisPickerViewControllerDelegate: class {
    func pickerViewDidAccept(value: String, index: Int)
}

class TardisPickerViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: TardisButton!
    @IBOutlet weak var acceptButton: TardisButton!
    weak var delegate: TardisPickerViewControllerDelegate?
    var selectedIndex = 0
    var dataSource = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showPickerView() {
        let pickerView = UIPickerView.init(frame: .init(x: 0,
                                                        y: self.view.frame.height - 160,
                                                        width: self.view.frame.width,
                                                        height: 160))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        self.view.bringSubviewToFront(pickerView)
        pickerView.selectRow(0, inComponent: 0, animated: true)
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
    @IBAction func acceptAction(_ sender: Any) {
        hide()
        guard let delegate = delegate else { return  }
        delegate.pickerViewDidAccept(value: dataSource[selectedIndex], index: selectedIndex)
    }
    @IBAction func backAction(_ sender: Any) {
        hide()
    }
}
extension TardisPickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard var label = view as? UILabel? else {
            return UIView()
        }
        if label == nil {
            label = UILabel()
        }
        label?.text = dataSource[row]
        label?.textAlignment = .center
        return label ?? UIView()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
}
