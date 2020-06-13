//
//  TardisNotLoginMenuCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/13/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisNotLoginMenuCollectionViewCellDelegate: class {
    func loginAction()
}

class TardisNotLoginMenuCollectionViewCell: UICollectionViewCell {
    // MARK: - Propeties
    weak var delegate: TardisNotLoginMenuCollectionViewCellDelegate?
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - IBActions
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.loginAction()
        }
    }
}
