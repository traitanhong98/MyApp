//
//  TardisLoadingView.swift
//  FireBase001
//
//  Created by Hoang on 5/8/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Lottie

class TardisLoadingView: TardisView {
    required init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let rootVC = CommonFunction.rootVC
        self.cornerRadius = 6
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        self.frame.size = .init(width: 100, height: 100)
        self.center = CGPoint(x: rootVC.view.frame.width / 2,
                                       y: rootVC.view.frame.height / 2)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        let animationView = AnimationView(name: "infinityLoading")
        animationView.frame.size = CGSize(width: 200, height: 200)
        animationView.center = CGPoint(x: self.frame.width / 2,
                                       y: self.frame.height / 2 - 10)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.5
        self.addSubview(animationView)
        let label = UILabel()
        label.frame = .init(x: 0, y: 70, width: 100, height: 20)
        label.contentMode = .center
        label.text = "Loading..."
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = UIColor.black
        self.addSubview(label)
        animationView.play()
    }
    
}
