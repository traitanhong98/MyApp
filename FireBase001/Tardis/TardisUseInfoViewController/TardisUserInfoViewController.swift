//
//  TardisUserInfoViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisUserInfoViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var backButton: TardisButton!
    @IBOutlet weak var editButton: TardisButton!
    @IBOutlet weak var editBlockView: TardisView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var changeInfoBlockView: UIView!
    @IBOutlet weak var changeInfoButton: TardisButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    // MARK: - Propety
    var avatarImg = UIImage(named: "edit") {
        didSet{
            self.avatarImageView.image = avatarImg
        }
    }
    var dataModel = TardisUserInfoDataModel()
    var isChangeAvatar = false
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupViewForCurrentUser()
    }
    // MARK: - Func
    func setupUI() {
        self.view.clipsToBounds = true
        self.view.layer.masksToBounds = true
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
        birthdayTextField.delegate = self
    }
    func setupData() {
        dataModel.selfView = self
    }
    func setupViewForCurrentUser() {
        let user = UserInfo.currentUser
        if user.displayName.count > 0 {
            usernameTextField.text = user.displayName
        } else {
            usernameTextField.text = user.email
        }
        emailTextField.text = user.email
        phoneNumberTextField.text = user.phoneNumber
        birthdayTextField.text = user.birthDay
        
        if user.imageUrl.count > 0 {
            guard let url = URL(string: user.imageUrl) else {return}
            CommonFunction.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.avatarImg = UIImage(data: data)
                }
            }
        }
        
    }
    func changeEditingMode(isEditing: Bool ) {
        usernameTextField.isUserInteractionEnabled = isEditing
        emailTextField.isUserInteractionEnabled = isEditing
        phoneNumberTextField.isUserInteractionEnabled = isEditing
        birthdayTextField.isUserInteractionEnabled = isEditing
        changeInfoBlockView.isHidden = !isEditing
    }
    func changeInfoAction(userInfo: UserInfoObject) {
        if isChangeAvatar {
            guard let newAva = avatarImg else {return}
            dataModel.updateCurrentUserInfo(userInfo: userInfo, avatar: newAva) { (status) in
                self.showPopupSuccess(isSuccess: status)
            }
        } else {
            dataModel.updateCurrentUserInfo(userInfo: userInfo) { (status) in
                self.showPopupSuccess(isSuccess: status)
            }
        }
    }
    func showPopupSuccess(isSuccess: Bool) {
        let popup = TardisPopup()
        var message = ""
        if isSuccess {
            message = "Cập nhật thành công!"
        } else {
            message = "Có lỗi xảy ra!"
        }
        popup.settingPoup(title: "Thông báo",
                          description: message,
                          isAcceptButton: true,
                          isBackButton: false)
        popup.show()
    }
    // MARK: - IBAction
    
    @IBAction func chooseAvatarButtonTapped(_ sender: Any) {
        let imagePicker = TardisImagePickerViewController()
        imagePicker.delegate = self
        imagePicker.show()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func changeUserInfoButtonTapped(_ sender: Any) {
        changeEditingMode(isEditing: false)
        guard let userName = usernameTextField.text else {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập tên hiển thị")
            return
        }
        guard let phoneNumber = phoneNumberTextField.text else {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập tên hiển thị")
            return
        }
        guard let birthDay = birthdayTextField.text else {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập tên hiển thị")
            return
        }
        let newUserInfo = dataModel.currentUserInfo
        newUserInfo.birthDay = birthDay
        newUserInfo.displayName = userName
        newUserInfo.phoneNumber = phoneNumber
        changeInfoAction(userInfo: newUserInfo)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension TardisUserInfoViewController: TardisImagePickerViewControllerDelegate {
    func didSelectEditedImage(image: UIImage) {
        isChangeAvatar = true
        self.avatarImg = image
    }
}

extension TardisUserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthdayTextField {
            self.view.endEditing(true)
            let datePicker = TardisDatePickerViewController()
            datePicker.delegate = self
            datePicker.show()
        }
    }
}
extension TardisUserInfoViewController:TardisDatePickerViewControllerDelegate{
    func selectedDate(date: String) {
        birthdayTextField.text = date
    }
    
    
}

