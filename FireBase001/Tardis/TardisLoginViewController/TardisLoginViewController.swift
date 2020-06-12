//
//  TardisLoginViewController.swift
//  FireBase001
//
//  Created by Hoang on 5/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisLoginViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var accountTextField: TardisTextField!
    @IBOutlet weak var passwordTextField: TardisTextField!
    @IBOutlet weak var loginButton: TardisButton!
    @IBOutlet weak var signupButton: TardisButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    // MARK: - Propeties
    let rootVC = CommonFunction.rootVC
    let requestModel = TardisLoginRequestModel.shared
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    // MARK: - Functions
    func setupUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.containerView.addGestureRecognizer(gesture)
        accountTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func hideKeyBoard() {
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    // MARK: - IBActions
    @IBAction func loginAction(_ sender: Any) {
        guard let account = accountTextField.text else {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập tài khoản")
            return
        }
        guard let password = passwordTextField.text else {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập mật khẩu")
            return
        }
        requestModel.login(username: account, password: password) { (status) in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    @IBAction func signupAction(_ sender: Any) {
        let signupVC = TardisSignupViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension TardisLoginViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        textField.resignFirstResponder()
        return true
    }
}
