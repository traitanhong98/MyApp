//
//  TardisImagePickerViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/20/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

protocol TardisImagePickerViewControllerDelegate:class {
    func didSelectEditedImage(image: UIImage)
}

class TardisImagePickerViewController: UIViewController {
    
    // MARK: - Propety
    weak var delegate: TardisImagePickerViewControllerDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Func
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
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { _ in
            self.hide()
        }
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
    
    func show() {
        self.view.frame = CommonFunction.rootVC.view.frame
        self.view.isUserInteractionEnabled = true
        CommonFunction.rootVC.addChild(self)
        CommonFunction.rootVC.view.addSubview(self.view)
        CommonFunction.rootVC.view.bringSubviewToFront(self.view)
        self.view.layoutIfNeeded()
        self.showAlertImagePicker()
    }
    func hide() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    // MARK: - IBAction
    @IBAction func backButtonTapped(_ sender: Any) {
        self.hide()
    }
}

extension TardisImagePickerViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[.editedImage] as? UIImage else {
            return
        }
        guard let delegate = delegate else {
            return
        }
        delegate.didSelectEditedImage(image: chosenImage)
        self.hide()
        picker.dismiss(animated: true, completion: nil)
    }
}
