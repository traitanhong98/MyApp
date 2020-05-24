//
//  UICollectionViewExtentiosn.swift
//  FireBase001
//
//  Created by Hoang on 5/24/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
//
//  UIViewExtension.swift
//  Heya
//
//  Created by TrungNV on 10/10/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
@objc public class TardisCollectionView: UICollectionView {
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
}

