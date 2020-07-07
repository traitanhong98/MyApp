//
//  TardisChannelCheckListViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChannelCheckListViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var checkListCollectionView: UICollectionView!
    @IBOutlet weak var filterTextField: UITextField!
    var page: TardisChannelPage!
    var currentChannel: TardisChannelObject!
    var checkList = [TardisChannelChecklistObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setupView()
        // Do any additional setup after loading the view.
    }
    func setupView() {
        filterTextField.delegate = self
    }
    func registerCollectionView() {
        checkListCollectionView.register(UINib(nibName: "TardisCheckListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisCheckListCollectionViewCell")
        checkListCollectionView.delegate = self
        checkListCollectionView.dataSource = self
    }
    func showFilterPicker() {
        let picker = TardisPickerViewController()
        picker.dataSource = ["Không xắp xếp","Người thực hiện","Loại công việc"]
        picker.delegate = self
        picker.show()
    }
    @IBAction func addCheckListAction(_ sender: Any) {
        let popupChecklist = AddCheckListPopup()
        popupChecklist.show()
    }

}
extension TardisChannelCheckListViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = checkListCollectionView.dequeueReusableCell(withReuseIdentifier: "TardisCheckListCollectionViewCell", for: indexPath) as? TardisCheckListCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width * 0.9,
                     height: self.view.frame.height * 0.9)
    }
}
extension TardisChannelCheckListViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == filterTextField {
            showFilterPicker()
            return false
        }
        return true
    }
}
extension TardisChannelCheckListViewController: TardisPickerViewControllerDelegate {
    func pickerViewDidAccept(value: String, index: Int) {
        filterTextField.text = value
    }
}
