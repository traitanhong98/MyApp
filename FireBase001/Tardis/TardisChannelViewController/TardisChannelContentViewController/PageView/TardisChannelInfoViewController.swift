//
//  TardisChannelInfoViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChannelInfoViewController: UIViewController {
    
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
//        registerTableView()
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
//    func registerTableView() {
//        memberTableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
//    }
    @IBAction func addMemberAction(_ sender: Any) {
        let popup = TardisFindUserPopup()
        popup.show()
    }
    
}
//extension TardisChannelInfoViewController: UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currentChannel.usersID.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = memberTableView.dequeueReusableCell(withIdentifier: "TardisUserlistTableViewCell", for: indexPath)
//            as? TardisUserlistTableViewCell else { return UITableViewCell() }
//        cell.bindData(
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let userPopup = TardisUserInfoPopup()
//        userPopup.currentUser = arrayUser[indexPath.row]
//        userPopup.delegate = self
//        userPopup.show()
//    }
//}
extension TardisChannelInfoViewController: TardisUserInfoPopupDelegate {
    func addFriend(user: UserInfoObject) {
        
    }
}
