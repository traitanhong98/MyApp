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
//        if accountTextField.text!.count > 0 && passwordTextField.text!.count > 0 {
//            Auth.auth().signIn(withEmail: accountTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
//              guard let strongSelf = self else { return }
//                UserInfo.setLogin()
//                self?.dismiss(animated: true, completion: nil)
//            }
//        }
    }
    @IBAction func signupAction(_ sender: Any) {
        let signupViewController = TardisSignupViewController()
//        signupViewController.modalPresentationStyle = .fullScreen
        self.present(signupViewController, animated: true, completion: nil)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate
extension TardisLoginViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
