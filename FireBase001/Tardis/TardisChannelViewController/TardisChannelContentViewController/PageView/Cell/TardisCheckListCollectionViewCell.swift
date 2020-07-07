//
//  TardisCheckListCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisCheckListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var assigneeLabel: UILabel!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var checklistTable: UITableView!
    var checkList = [TardisChannelChecklistObject]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerTableView()
    }
    func registerTableView() {
        checklistTable.register(UINib(nibName: "TardisChannelCheckListTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisChannelCheckListTableViewCell")
        checklistTable.delegate = self
        checklistTable.dataSource = self
        checklistTable.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    func bindData(checkList: [TardisChannelChecklistObject], isAssined: Bool) {
        if isAssined {
            let path = "Users/" + checkList[0].assignee
            TardisBaseRequestModel.shared.getStringFromPath(path) { value in
                self.assigneeLabel.text = value
            }
        } else {
            assigneeLabel.text = "Checklist"
        }
        self.checkList = checkList
        checklistTable.reloadData()
    }
}
extension TardisCheckListCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return checkList.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = checklistTable.dequeueReusableCell(withIdentifier: "TardisChannelCheckListTableViewCell", for: indexPath) as? TardisChannelCheckListTableViewCell else {
            return UITableViewCell()
        }
//        cell.bindData(checkListObject: checkList[indexPath.row])
        return cell
    }
}
