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
    @IBInspectable var radius: CGFloat = 6 {
        didSet {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
    }
    @IBInspectable var borderColor: UIColor = .green {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var enableBackgroundColor: UIColor = .blue {
           didSet {
               guard isEnabled else { return }
               backgroundColor = enableBackgroundColor
           }
       }
       
    @IBInspectable var disableBackgroundColor: UIColor = .gray {
           didSet {
               guard !isEnabled else { return }
               backgroundColor = disableBackgroundColor
           }
       }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            if borderWidth > 0 {
                self.layer.borderWidth = borderWidth
            }
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
