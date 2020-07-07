//
//  TardisChannelCheckListTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisChannelCheckListTableViewCellDelegate: class {
    func check(inCheckListObject object: TardisChannelChecklistObject, atIndexPath indexPath: IndexPath)
    func delete(checkListObject object: TardisChannelChecklistObject, atIndexPath indexPath: IndexPath)
}
class TardisChannelCheckListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var checkListTextField: UITextField!
    weak var delegate: TardisChannelCheckListTableViewCellDelegate?
    var checkList = TardisChannelChecklistObject()
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        checkListTextField.delegate = self
        checkButton.isSelected = false
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func bindData(checkListObject: TardisChannelChecklistObject, indexPath: IndexPath) {
        checkListTextField.text = checkListObject.note
        checkList = checkListObject
        self.indexPath = indexPath
    }
    @IBAction func selecAction(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
        checkList.status = !checkList.status
        guard let delegate = delegate, let indexPath = indexPath else { return }
        delegate.check(inCheckListObject: checkList, atIndexPath: indexPath)
    }
    @IBAction func deleteAction(_ sender: Any) {
        guard let delegate = delegate, let indexPath = indexPath else { return }
        delegate.delete(checkListObject: checkList, atIndexPath: indexPath)
    }
    
}
extension TardisChannelCheckListTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
