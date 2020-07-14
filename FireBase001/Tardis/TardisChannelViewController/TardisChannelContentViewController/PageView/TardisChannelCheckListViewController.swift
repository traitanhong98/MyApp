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
    var sortedChecklist = [[TardisChannelChecklistObject]]()
    var dataModel = TardisChannelDataModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setupView()
        observeChecklist()
    }
    func setupView() {
        filterTextField.delegate = self
    }
    func observeChecklist() {
        dataModel.observeCheckList(onChannel: currentChannel) { (status, listObject) in
            self.checkList = listObject
            self.sortChecklist()
        }
    }
    func sortChecklist() {
        var newList = [[TardisChannelChecklistObject]]()
        switch filterTextField.text {
        case "Không xắp xếp":
            newList.append(checkList)
        case "Người thực hiện":
            for object in checkList {
                if newList.count == 0 {
                    newList.append([object])
                } else {
                    var isAdded = false
                    for index in 0..<newList.count {
                        if newList[index][0].assignee == object.assignee {
                            newList[index].append(object)
                            isAdded = true
                            break
                        }
                    }
                    if isAdded == false {
                        newList.append([object])
                    }
                }
            }
        case "Loại công việc":
            for object in checkList {
                if newList.count == 0 {
                    newList.append([object])
                } else {
                    var isAdded = false
                    for index in 0..<newList.count {
                        if newList[index][0].tag == object.tag {
                            newList[index].append(object)
                            isAdded = true
                            break
                        }
                    }
                    if isAdded == false {
                        newList.append([object])
                    }
                }
            }
        default:
            break
        }
        sortedChecklist = newList
        checkListCollectionView.reloadData()
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
        popupChecklist.currentChannel = currentChannel
        popupChecklist.delegate = self
        popupChecklist.show()
    }
}
extension TardisChannelCheckListViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedChecklist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = checkListCollectionView.dequeueReusableCell(withReuseIdentifier: "TardisCheckListCollectionViewCell", for: indexPath) as? TardisCheckListCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard sortedChecklist.count > 0 else { return cell }
        switch filterTextField.text {
        case "Không xắp xếp":
            cell.bindData(checkList: sortedChecklist[indexPath.row], title: "Toàn bộ công việc", isAssined: false)
        case "Người thực hiện":
            cell.bindData(checkList: sortedChecklist[indexPath.row], title: "", isAssined: true)
        case "Loại công việc":
            cell.bindData(checkList: sortedChecklist[indexPath.row], title: sortedChecklist[indexPath.row][0].tag, isAssined: false)
        default:
            break
        }
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width,
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
        sortChecklist()
    }
}
extension TardisChannelCheckListViewController: AddCheckListPopupDelegate {
    func addCheckListObject(object: TardisChannelChecklistObject) {
        dataModel.addNewCheckList(object,
                                  toChannel: currentChannel) { (status) in
                                    if status {
                                        self.checkListCollectionView.reloadData()
                                    }
        }
    }
}
extension TardisChannelCheckListViewController: TardisCheckListCollectionViewCellDelegate {
    func check(inCheckListObject object: TardisChannelChecklistObject) {
        TardisChannelRequestModel.shared.checkListRef.child(currentChannel.checkListID).child(object.id).setValue(object.toJSON())
    }
    func delete(checkListObject object: TardisChannelChecklistObject) {
        TardisChannelRequestModel.shared.checkListRef.child(currentChannel.checkListID).child(object.id).removeValue()
    }
    
    
}
