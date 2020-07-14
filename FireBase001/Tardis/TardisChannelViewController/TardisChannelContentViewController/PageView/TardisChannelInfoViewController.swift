//
//  TardisChannelInfoViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChannelInfoViewController: UIViewController {
    
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var changeInfoButton: TardisButton!
    @IBOutlet weak var activityNameLabel: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var addMemberButton: TardisButton!
    @IBOutlet weak var quitButton: TardisButton!
    var currentChannel: TardisChannelObject!
    var page: TardisChannelPage!
    let dataModel = TardisChannelDataModel.shared
    let currentActivity = TardisChannelActivityObject()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeActivity()
        registerTableView()
    }
    func observeActivity() {
        dataModel.observeActivity(onChannel: currentChannel) { (status, object) in
            if status {
                self.activityNameLabel.text = object.name
                self.startDateTextField.text = object.startDay
                self.endDateTextField.text = object.endDay
                self.noteTextView.text = object.note
            }
        }
    }
    func setupUI() {
        if UserInfo.getUID() == currentChannel.ownerID {
            addMemberButton.isHidden = false
            quitButton.isHidden = true
            changeInfoButton.isHidden = false
        } else {
            addMemberButton.isHidden = true
            changeInfoButton.isHidden = true
            quitButton.isHidden = false
        }
    }
    func registerTableView() {
        memberTableView.register(UINib(nibName: "TardisInvitationTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisInvitationTableViewCell")
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
    }
    @IBAction func addMemberAction(_ sender: Any) {
        let popup = TardisFindUserPopup()
        popup.delegate = self
        popup.show()
    }
    @IBAction func changeInfoAction(_ sender: Any) {
        currentActivity.endDay = endDateTextField.text ?? ""
        currentActivity.startDay = startDateTextField.text ?? ""
        currentActivity.name = activityNameLabel.text ?? ""
        currentActivity.note = noteTextView.text ?? ""
        TardisChannelRequestModel.shared.addNewActivity(currentActivity,
                                                        toChannel: currentChannel) { (status) in
                                                            CommonFunction.annoucement(title: "", message: "Cập nhật thành công")
        }
    }
    
}
extension TardisChannelInfoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentChannel.usersID.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = memberTableView.dequeueReusableCell(withIdentifier: "TardisInvitationTableViewCell", for: indexPath)
            as? TardisInvitationTableViewCell else { return UITableViewCell() }
        cell.bindData(uid: currentChannel.usersID[indexPath.row])
        cell.acceptButton.isHidden = true
        cell.rejectButton.isHidden = currentChannel.ownerID != UserInfo.getUID()
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TardisBaseRequestModel.shared.getUser(UID: currentChannel.usersID[indexPath.row]) { (status, user) in
            if status {
                let userPopup = TardisUserInfoPopup()
                userPopup.currentUser = user
                userPopup.delegate = self
                userPopup.show()
            }
        }
    }
}
extension TardisChannelInfoViewController: TardisUserInfoPopupDelegate {
    func addFriend(user: UserInfoObject) {
    }
}
extension TardisChannelInfoViewController: TardisFindUserPopupDelegate {
    func didSelectUser(user: UserInfoObject) {
        if !currentChannel.usersID.contains(user.UID) {
            currentChannel.usersID.append(user.UID)
            user.channels.append(currentChannel.id)
            TardisChannelRequestModel.shared.channelRef.child(currentChannel.id).child("users_ID").setValue(currentChannel.usersID)
            TardisBaseRequestModel.shared.firRef.child("Users").child(user.UID).child("channels").setValue(user.channels)
            memberTableView.reloadData()
        }
    }
    
    
}

extension TardisChannelInfoViewController: TardisInvitationTableViewCellDelegate {
    func didAcceptInvitation(of user: UserInfoObject) {
    }
    func didRejectInvitation(of user: UserInfoObject) {
        if let indexUser = currentChannel.usersID.firstIndex(of: user.UID),
            let indexChannel = user.channels.firstIndex(of: currentChannel.id){
            currentChannel.usersID.remove(at: indexUser)
            user.channels.remove(at: indexChannel)
            TardisChannelRequestModel.shared.channelRef.child(currentChannel.id).child("users_ID").setValue(currentChannel.usersID)
            TardisBaseRequestModel.shared.firRef.child("Users").child(user.UID).child("channels").setValue(user.channels)
            memberTableView.reloadData()
        }
    }
}
