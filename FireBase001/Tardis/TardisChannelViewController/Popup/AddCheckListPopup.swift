//
//  AddCheckListPopup.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class AddCheckListPopup: TardisBasePopupViewController {

    @IBOutlet weak var checkListConentTextField: UITextField!
    @IBOutlet weak var assigneeTextField: UITextField!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var contentView: TardisView!
    
    // MARK: - ListUser
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListConentTextField.delegate = self
        assigneeTextField.delegate = self
        animateView = contentView
    }
    func showTableView() {
        usersTableView.isHidden = true
    }
    @IBAction func addAction(_ sender: Any) {
        hide()
    }
    @IBAction func closeAction(_ sender: Any) {
        hide()
    }
}
extension AddCheckListPopup: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == assigneeTextField {
            self.showTableView()
            return false
        }
        return true
    }
}
