//
//  TardisCreateChannelPopup.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisCreateChannelPopupDelegate: class {
    func createChannel(_ name: String)
}

class TardisCreateChannelPopup: TardisBasePopupViewController {

    @IBOutlet weak var contentView: TardisView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var channelNameTextField: UITextField!
    weak var delegate: TardisCreateChannelPopupDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        animateView = contentView
        // Do any additional setup after loading the view.
    }


    @IBAction func acceptButtonAction(_ sender: Any) {
        if (channelNameTextField.text ?? "").count > 0 {
            self.hide()
            guard let delegate = delegate else {
                CommonFunction.annoucement(title: "", message: "Có lỗi xảy ra")
                return
            }
            delegate.createChannel(channelNameTextField.text ?? "")
        } else {
            CommonFunction.annoucement(title: "", message: "Bạn cần nhập tên nhóm mới")
        }
    }
    @IBAction func closeAction(_ sender: Any) {
        self.hide()
    }
}
