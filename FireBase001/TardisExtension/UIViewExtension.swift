//
//  UIViewExtension.swift
//  Heya
//
//  Created by TrungNV on 10/10/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView
extension UIView{
    func setRadius(_ radius: CGFloat = NORMAL_RADIUS) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    func createShadow(scale: Bool = true, color shadowColor: UIColor = SHADOW_VIEW_COLOR) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
}
@IBDesignable
@objc public class TardisView: UIView {
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
    
    @IBInspectable var isShadow: Bool = false {
        didSet {
            if isShadow {
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowOffset = shadowOffset
                self.layer.shadowOpacity = shadowOpacity
                self.layer.shadowRadius = shadowRadius
            }
        }
    }
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    convenience init() {
        self.init(frame: .zero)
    }
    func setupUI() {
        if self.isShadow {
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowRadius = cornerRadius
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}

// MARK: - Label
@IBDesignable
class TardisLabel: UILabel {
    
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
       
       @IBInspectable var shadowRadius: CGFloat = 5 {
           didSet {
               self.layer.shadowRadius = shadowRadius
           }
       }
}

extension UIView {
    
    func fill(left: CGFloat? = 0, top: CGFloat? = 0, right: CGFloat? = 0, bottom: CGFloat? = 0) {
        guard let superview = superview else {
            print("\(self.description): there is no superView")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        if let left = left {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        }
        if let top = top  {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        
        if let right = right {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        }
    }
}

// MARK: - UIImageView
@IBDesignable
@objc public class TardisImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = UIColor.clear.cgColor
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
    
    @IBInspectable var isShadow: Bool = false {
        didSet {
            if isShadow {
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowOffset = shadowOffset
                self.layer.shadowOpacity = shadowOpacity
                self.layer.shadowRadius = shadowRadius
            }
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    convenience init() {
        self.init(frame: .zero)
    }
    func setupUI() {
        if self.isShadow {
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowRadius = cornerRadius
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
// MARK: - TextView
@IBDesignable
@objc public class TardisTextView: UITextView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = UIColor.clear.cgColor
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
    
    @IBInspectable var isShadow: Bool = false {
        didSet {
            if isShadow {
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowOffset = shadowOffset
                self.layer.shadowOpacity = shadowOpacity
                self.layer.shadowRadius = shadowRadius
            }
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
