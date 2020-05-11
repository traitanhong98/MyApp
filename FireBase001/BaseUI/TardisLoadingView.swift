//
//  TardisLoadingView.swift
//  FireBase001
//
//  Created by Hoang on 5/8/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisLoadingView: UIView {

    var contentView:UIView?
    var loadingImage:UIImageView?
    var loadingTextView:UIView?
    var isAnimating = true
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        contentView = UIView.init(frame: CGRect(x: 0, y: 0, width: 66, height: 66))
        contentView?.backgroundColor = UIColor.white
        contentView?.center = self.center
        contentView?.alpha = 0
        self.addSubview(contentView!)
        
        contentView?.layer.cornerRadius = contentView!.frame.size.height/2
        contentView?.layer.masksToBounds = true
        contentView?.clipsToBounds = false
        contentView?.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        contentView?.layer.shadowRadius = 2
        contentView?.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
}
