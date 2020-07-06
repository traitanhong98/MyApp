//
//  TardisUserListViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisUserListViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var arrayUser = [UserInfoObject]()
    var sortedArray = [UserInfoObject]()
    var sortedName = ""
    var dataModel = TardisChatDataModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        observeUsers()
    }
    func observeUsers() {
        TardisBaseRequestModel.shared.observeAllOtherUsers { (status, listUser) in
            if status {
                self.arrayUser = listUser
                self.usersTableView.reloadData()
            }
        }
    }
    func registerTableView() {
        usersTableView.register(UINib(nibName: "TardisUserlistTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "TardisUserlistTableViewCell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension TardisUserListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "TardisUserlistTableViewCell", for: indexPath)
            as? TardisUserlistTableViewCell else { return UITableViewCell() }
        cell.bindData(user: arrayUser[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userPopup = TardisUserInfoPopup()
        userPopup.currentUser = arrayUser[indexPath.row]
        userPopup.delegate = self
        userPopup.show()
    }
}
extension TardisUserListViewController: TardisUserInfoPopupDelegate {
    func addFriend(user: UserInfoObject) {
        dataModel.inviteFriend(otherUser: user) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Gửi lời mời thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Gửi lời mời thất bại")
            }
        }
    }
}
