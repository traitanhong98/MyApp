//
//  TardisCheckListCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisCheckListCollectionViewCellDelegate: class {
    func check(inCheckListObject object: TardisChannelChecklistObject)
    func delete(checkListObject object: TardisChannelChecklistObject)
}


class TardisCheckListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var assigneeLabel: UILabel!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var checklistTable: UITableView!
    @IBOutlet weak var containerView: UIView!
    var checkList = [TardisChannelChecklistObject]()
    weak var delegate: TardisCheckListCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerTableView()
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }
    func registerTableView() {
        checklistTable.register(UINib(nibName: "TardisChannelCheckListTableViewCell", bundle: nil), forCellReuseIdentifier: "TardisChannelCheckListTableViewCell")
        checklistTable.delegate = self
        checklistTable.dataSource = self
        checklistTable.contentInset = .init(top: 40, left: 0, bottom: 0, right: 0)
    }
    func bindData(checkList: [TardisChannelChecklistObject],title: String, isAssined: Bool) {
        if isAssined {
            let path = "Users/" + checkList[0].assignee + "/display_name"
            TardisBaseRequestModel.shared.getStringFromPath(path) { value in
                self.assigneeLabel.text = value
            }
        } else {
            assigneeLabel.text = title
        }
        self.checkList = checkList
        checklistTable.reloadData()
        
    }
}
extension TardisCheckListCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = checklistTable.dequeueReusableCell(withIdentifier: "TardisChannelCheckListTableViewCell", for: indexPath) as? TardisChannelCheckListTableViewCell else {
            return UITableViewCell()
        }
        cell.bindData(checkListObject: checkList[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension TardisCheckListCollectionViewCell: TardisChannelCheckListTableViewCellDelegate {
    func check(inCheckListObject object: TardisChannelChecklistObject, atIndexPath indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        delegate.check(inCheckListObject: object)
    }
    
    func delete(checkListObject object: TardisChannelChecklistObject, atIndexPath indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        delegate.delete(checkListObject: object)
    }
    
    
}
