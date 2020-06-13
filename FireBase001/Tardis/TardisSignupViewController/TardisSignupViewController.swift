//
//  TardisSignupViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisSignupViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var usernameTextField: TardisTextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK: - Var
    var dataModel = TardisSignUpDataModel()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataModel.selfView = self
    }


    // MARK: - Func
    func registerAction() {
        guard   let userName = usernameTextField.text,
                let password = passwordTextField.text,
                let repassword = repasswordTextField.text else {
                    CommonFunction.annoucement(title: "", message: "Bạn cần nhập đủ thông tin")
                    return
        }
        if userName.count == 0 || password.count == 0 || repassword.count == 0 {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập đủ thông tin")
            return
        }
        if password != repassword {
            CommonFunction.annoucement(title: "", message: "Mật khẩu không khớp")
        }
        dataModel.registerNewUser(username: userName, password: password) { status in
            if status {
                CommonFunction.annoucement(title: "", message: "Đăng ký thành công")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                CommonFunction.annoucement(title: "", message: "Đăng ký thất bại")
            }
        }
    }
    
    func setupUI() {
        self.view.bringSubviewToFront(containerView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(gesture)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        repasswordTextField.delegate = self
        
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    // MARK: - IBAction
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
        self.registerAction()
    }
}

extension TardisSignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
