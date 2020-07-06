//
//  TardisAddFriendViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/7/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisAddFriendViewController: UIViewController {

    var dataModel = TardisChatDataModel.shared
    var listInvitation = [TardisFriendObject]()
    @IBOutlet weak var invitationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    func registerCell() {
        invitationTableView.register(UINib(nibName: "TardisInvitationTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisInvitationTableViewCell")
        invitationTableView.delegate = self
        invitationTableView.dataSource = self
    }

    @IBAction func closeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
extension TardisAddFriendViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listInvitation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = invitationTableView.dequeueReusableCell(withIdentifier: "TardisInvitationTableViewCell", for: indexPath)
            as? TardisInvitationTableViewCell else { return UITableViewCell() }
        cell.bindData(friend: listInvitation[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension TardisAddFriendViewController: TardisInvitationTableViewCellDelegate {
    func didAcceptInvitation(of user: UserInfoObject) {
        dataModel.acceptInvitation(ofUser: user) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Đã chấp nhận lời mời kết bạn")
            } else {
                CommonFunction.annoucement(title: "", message: "Có lỗi xảy ra")
            }
        }
    }
    
    func didRejectInvitation(of user: UserInfoObject) {
        dataModel.rejectInvitation(ofUser: user) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Đã xoá lời mời kết bạn")
            } else {
                CommonFunction.annoucement(title: "", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
}
