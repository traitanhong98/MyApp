//
//  TardisChannelCheckListTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
class TardisChannelCheckListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var checkListTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkListTextField.delegate = self
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(checkListObject: TardisChannelChecklistObject) {
        checkListTextField.text = checkListObject.note
    }
    
}
extension TardisChannelCheckListTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
