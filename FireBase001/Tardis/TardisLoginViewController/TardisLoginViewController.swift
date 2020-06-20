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
    var dataModel = TardisLoginDataModel()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        addBackGround()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    // MARK: - Functions
    func addBackGround() {
        let backGroundImage = UIImageView(image: UIImage(named: "tardisTheme002"))
        backGroundImage.frame = self.view.frame
        backGroundImage.center = self.view.center
        backGroundImage.contentMode = .scaleAspectFill
        backGroundImage.alpha = 0.8
        backGroundImage.clipsToBounds = true
        self.view.addSubview(backGroundImage)
        self.view.sendSubviewToBack(backGroundImage)
    }
    func setupUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.containerView.addGestureRecognizer(gesture)
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame = .init(x: 0,
                                y: -110,
                                width: self.view.frame.width,
                                height: self.view.frame.height)
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame = .init(x: 0,
                                y: 0,
                                width: self.view.frame.width,
                                height: self.view.frame.height)
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
        if account.count == 0 || password.count == 0 {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập tài khoản/ mật khẩu trước")
            return
        }
        dataModel.doLogin(username: account, password: password) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Đăng nhập thành công")
                self.navigationController?.popViewController(animated: true)
                CommonFunction.rootVC.initTabbar()
            }
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
