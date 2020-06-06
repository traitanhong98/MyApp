//
//  TardisSettingViewController.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisSettingViewController: BaseTabViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    // MARK: - Propeties
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTable()
    }
    // MARK: - Func
    func registerTable(){
        settingTableView.register(UINib(nibName: "TardisUserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisUserInfoTableViewCell")
        settingTableView.register(UINib(nibName: "TardisSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisSettingTableViewCell")
        initLayoutForTableView(settingTableView)
        settingTableView.separatorStyle = .none
    }
    
    func initLayoutForTableView(_ tableView: UITableView){
        tableView.decelerationRate = .fast
        tableView.delegate = self
        tableView.dataSource = self
     }
    

}
// MARK: - TableViewDelegate
extension TardisSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell =  tableView.dequeueReusableCell(withIdentifier: "TardisUserInfoTableViewCell", for: indexPath) as? TardisSettingTableViewCell {
                return cell
            }
        } else {
            if let cell =  tableView.dequeueReusableCell(withIdentifier: "TardisSettingTableViewCell", for: indexPath) as? TardisSettingTableViewCell {
                cell.bindData(setting: Setting.getSetting(index: indexPath.row))
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case Setting.userInfo.settingIndex:
            if let rootVC = self.view.window?.rootViewController as? TardisMainTabbarViewController {
                rootVC.openLogin()
            }
            break
        case Setting.commonSetting.settingIndex:
            break
        case Setting.appInfo.settingIndex:
            break
        case Setting.devInfo.settingIndex:
            break
        default:
            print("Errr")
        }
    }
}
