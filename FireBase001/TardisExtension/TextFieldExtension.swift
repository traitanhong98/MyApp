//
//  TextFieldExtension.swift
//  FireBase001
//
//  Created by Hoang on 5/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

@IBDesignable
class TardisTextField: UITextField {
    @IBInspectable
    var border: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = border
        }
    }
    @IBInspectable
    var borderColor: UIColor = UIColor.blue {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
