//
//  ButtonExtension.swift
//  FireBase001
//
//  Created by Hoang on 5/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

@IBDesignable
class TardisButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 1) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    // MARK: - Style
    func setTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
    func setFont(_ font: UIFont) {
        titleLabel?.font = font
    }
    
    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @objc fileprivate func setupUI() {
        isExclusiveTouch = true
    }
}
