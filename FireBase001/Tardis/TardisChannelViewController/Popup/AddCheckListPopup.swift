//
//  AddCheckListPopup.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

protocol AddCheckListPopupDelegate: class {
    func addCheckListObject(object: TardisChannelChecklistObject)
}

class AddCheckListPopup: TardisBasePopupViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usersView: TardisView!
    @IBOutlet weak var checkListConentTextField: UITextField!
    @IBOutlet weak var assigneeTextField: UITextField!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var contentView: TardisView!
    var currentChannel: TardisChannelObject!
    weak var delegate: AddCheckListPopupDelegate?
    var currentObject =  TardisChannelChecklistObject()
    var currentAssignee = UserInfoObject()
    // MARK: - ListUser
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListConentTextField.delegate = self
        assigneeTextField.delegate = self
        animateView = containerView
        usersView.isHidden = true
        tagTextField.delegate = self
        registerTable()
    }
    
    func registerTable() {
        usersTableView.register(UINib(nibName: "TardisInvitationTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisInvitationTableViewCell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    func showTableView() {
        usersView.isHidden = false
    }
    func showPickerView() {
        let picker = TardisPickerViewController()
        picker.dataSource = listTag
        picker.delegate = self
        picker.show()
    }
    @IBAction func addAction(_ sender: Any) {
        currentObject.assignee = currentAssignee.UID
        currentObject.note = checkListConentTextField.text ?? ""
        currentObject.tag = tagTextField.text ?? ""
        guard let delegate = delegate else {
            return
        }
        delegate.addCheckListObject(object: currentObject)
        hide()
    }
    @IBAction func closeAction(_ sender: Any) {
        hide()
    }
}
extension AddCheckListPopup: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case assigneeTextField:
            self.showTableView()
            return false
        case tagTextField:
            self.showPickerView()
            return false
        default:
            return true
        }
    }
    
}
extension AddCheckListPopup: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentChannel.usersID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "TardisInvitationTableViewCell", for: indexPath)
            as? TardisInvitationTableViewCell else { return UITableViewCell() }
        cell.bindData(uid: currentChannel.usersID[indexPath.row])
        cell.rejectButton.isHidden = true
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension AddCheckListPopup: TardisInvitationTableViewCellDelegate {
    func didAcceptInvitation(of user: UserInfoObject) {
        currentAssignee = user
        assigneeTextField.text = user.displayName
        usersView.isHidden = true
    }
    func didRejectInvitation(of user: UserInfoObject) {
    }
}
extension AddCheckListPopup: TardisPickerViewControllerDelegate {
    func pickerViewDidAccept(value: String, index: Int) {
        tagTextField.text = value
    }
}
