//
//  TardisFindUserPopup.swift
//  FireBase001
//
//  Created by Hoang on 7/8/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol  TardisFindUserPopupDelegate: class {
    func didSelectUser(user: UserInfoObject)
}
class TardisFindUserPopup: TardisBasePopupViewController {
    @IBOutlet weak var containerView: TardisView!
    @IBOutlet weak var usersTableView: UITableView!
    var arrayUser = [UserInfoObject]()
    var selectedUser = [UserInfoObject]()
    weak var delegate: TardisFindUserPopupDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        observeUsers()
        animateView = containerView
    }
    func registerTableView() {
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    func observeUsers() {
        TardisBaseRequestModel.shared.getListALLOtherUser { (status, listUser) in
            if status {
                self.arrayUser = listUser
                self.usersTableView.reloadData()
            }
        }
    }
    
    @IBAction func acceptAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
        hide()
    }
}
extension TardisFindUserPopup: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(user: arrayUser[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hide()
        guard let delegate = delegate else {
            return
        }
        delegate.didSelectUser(user: arrayUser[indexPath.row])
    }
}
