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
    var uid = ""
    var avatarImg = UIImage(named: "appLogo")
    var dataModel = TardisUserInfoDataModel()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    override func viewWillAppear(_ animated: Bool) {
        if uid == UserInfo.getUID() {
            setupViewForCurrentUser()
        }
    }
    // MARK: - Func
    func setupUI() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
    }
    func setupData() {
        dataModel.selfView = self
    }
    func setupViewForCurrentUser() {
        let user = UserInfo.getUserInfo()
        usernameTextField.text  = user?.email
        emailTextField.text = user?.email
    }
    func changeEditingMode(isEditing: Bool ) {
        usernameTextField.isUserInteractionEnabled = isEditing
        emailTextField.isUserInteractionEnabled = isEditing
        phoneNumberTextField.isUserInteractionEnabled = isEditing
        birthdayTextField.isUserInteractionEnabled = isEditing
        changeInfoBlockView.isHidden = !isEditing
        animatingEditButton(isHidden: isEditing)
    }
    func animatingEditButton(isHidden: Bool) {
            if isHidden {
                self.editBlockView.frame = .init(x: 100,
                                                 y: 100,
                                                 width: self.editBlockView.frame.width,
                                                 height: self.editBlockView.frame.width)
            } else {
                self.editBlockView.frame = .init(x: 0,
                                                 y: 0,
                                                 width: self.editBlockView.frame.width,
                                                 height: self.editBlockView.frame.width)
            }
    }
    func showAlertImagePicker() {
        let alert = UIAlertController.init(title: "Chọn nguồn",
                                           message: nil,
                                           preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction.init(title: "Camera", style: .default) { _ in
            self.showImagePicker(isCamera: true)
        }
        let galleryAction = UIAlertAction.init(title: "Gallery", style: .default) { _ in
            self.showImagePicker(isCamera: false)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        if CommonFunction.isIpad() {
            alert.modalPresentationStyle = .popover
            let popoverPresentation = alert.popoverPresentationController
            popoverPresentation?.sourceView = self.view
            popoverPresentation?.sourceRect = .zero
            self.present(alert, animated: true, completion: nil)
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    func showImagePicker(isCamera: Bool) {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.navigationBar.barTintColor = UIColor(red: 0, green: 37, blue: 77, alpha: 1)
        if isCamera {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                CommonFunction.annoucement(title: "", message: "Image Picker Error")
                print("Error: ImagePickerController cannot Access Camera")
                return
            }
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    // MARK: - IBAction
    
    @IBAction func chooseAvatarButtonTapped(_ sender: Any) {
        self.showAlertImagePicker()
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
        guard let avatar = avatarImg else {
            CommonFunction.annoucement(title: "", message: "Bạn cần chọn một Avatar")
            return
        }
        //        changeEditingMode(isEditing: true)
        let userInfo = dataModel.currentUserInfo
        userInfo.birthDay = birthDay
        userInfo.displayName = userName
        userInfo.phoneNumber = phoneNumber
        dataModel.updateCurrentUserInfo(userInfo: userInfo, avatar: avatar) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Cập nhật dữ liệu thành công")
            } else {
                CommonFunction.annoucement(title: "", message: "Cập nhật dữ liệu thất bại")
            }
        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TardisUserInfoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[.editedImage] as? UIImage else {
            return
        }
        self.avatarImg = chosenImage
        self.avatarImageView.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
    }
}
