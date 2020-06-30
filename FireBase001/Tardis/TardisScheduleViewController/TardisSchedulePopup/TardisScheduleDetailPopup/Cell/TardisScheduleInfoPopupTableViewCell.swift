//
//  TardisScheduleInfoPopupTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/29/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

protocol TardisScheduleInfoPopupTableViewCellDelegate: class {
    func check(inCheckListObject object: TardisCheckListObject, atIndexPath indexPath: IndexPath)
    func delete(checkListObject object: TardisCheckListObject, atIndexPath indexPath: IndexPath)
}

class TardisScheduleInfoPopupTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var desTextField: UITextField!
    weak var delegate: TardisScheduleInfoPopupTableViewCellDelegate?
    var checkList = TardisCheckListObject() {
        didSet {
            desTextField.text = checkList.des
            checkButton.isSelected = checkList.status
        }
    }
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(checkListObject object: TardisCheckListObject, atIndexPath indexPath: IndexPath) {
        checkList = object
        self.indexPath = indexPath
    }
    func setupUI() {
        checkButton.isSelected = false
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
        checkList.status = !checkList.status
        guard let delegate = delegate, let indexPath = indexPath else { return }
        delegate.check(inCheckListObject: checkList, atIndexPath: indexPath)
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let delegate = delegate, let indexPath = indexPath else { return }
        delegate.delete(checkListObject: checkList, atIndexPath: indexPath)
    }
}
