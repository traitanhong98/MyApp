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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func leftMenuAction(_ sender: Any) {
        CommonFunction.rootVC.showLeftViewAnimated()
    }
    @IBAction func invitedAction(_ sender: Any) {
    }
    @IBAction func findFriendButton(_ sender: Any) {
        let userList = TardisUserListViewController()
        self.navigationController?.pushViewController(userList, animated: true)
    }
    
}
