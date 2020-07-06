//
//  TardisChatViewController.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChatViewController: BaseTabViewController {

    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var findFriendButton: UIButton!
    @IBOutlet weak var invitedButton: TardisButton!
    @IBOutlet weak var friendTable: UITableView!
    let dataModel = TardisChatDataModel.shared
    var listFriend = [TardisFriendObject] ()
    var listPendingFriend = [TardisFriendObject] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        observeFriend()
    }

    func observeFriend() {
        dataModel.observeFriend(status: FriendStatus.connected) { (status, listFriend) in
            if status {
                self.listFriend = listFriend
                self.friendTable.reloadData()
            }
        }
        dataModel.observeFriend(status: FriendStatus.waiting) { (status, listWaiting) in
            if status {
                self.listPendingFriend = listWaiting
                if listWaiting.count == 0 {
                    self.invitedButton.isHidden = true
                } else {
                    self.invitedButton.isHidden = false
                    self.invitedButton.setImage(UIImage(), for: .normal)
                    self.invitedButton.setTitle("\(listWaiting.count)")
                }
            }
        }
    }
    
    func registerTable() {
        friendTable.register(UINib(nibName: "TardisUserlistTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisUserlistTableViewCell")
        friendTable.delegate = self
        friendTable.dataSource = self
        friendTable.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
    }
    @IBAction func leftMenuAction(_ sender: Any) {
        CommonFunction.rootVC.showLeftViewAnimated()
    }
    @IBAction func invitedAction(_ sender: Any) {
        let invitationVC = TardisAddFriendViewController()
        invitationVC.listInvitation = listPendingFriend
        self.navigationController?.pushViewController(invitationVC, animated: true)
    }
    @IBAction func findFriendButton(_ sender: Any) {
        let userList = TardisUserListViewController()
        self.navigationController?.pushViewController(userList, animated: true)
    }
}
extension TardisChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friendTable.dequeueReusableCell(withIdentifier: "TardisUserlistTableViewCell", for: indexPath)
            as? TardisUserlistTableViewCell else { return UITableViewCell() }
        cell.bindData(friend: listFriend[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = TardisChatingViewController()
        chatView.path = listFriend[indexPath.row].messageID
        self.navigationController?.pushViewController(chatView, animated: true)
    }
}
