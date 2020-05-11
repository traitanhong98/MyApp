//
//  LoadingView.swift
//  Heya
//
//  Created by TrungNV on 10/12/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet var contentView: UIView!
    
    func show() {
       var topController = UIApplication.shared.keyWindow?.rootViewController
              while (topController?.presentedViewController != nil) {
                  topController = topController?.presentedViewController
              }
              topController?.view.addSubview(self)
    }
    
    func hide() {
        self.removeFromSuperview()
    }
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        commonInit()
        initLottie()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
            initLottie()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
            initLottie()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    private func initLottie(){
        let starAnimationView = AnimationView(name: "lf30_editor_p7nm7J")

        /// Some time later
        let starAnimation = Animation.named("lf30_editor_p7nm7J")
        starAnimationView.animation = starAnimation
        starAnimationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        starAnimationView.contentMode = .scaleAspectFit
        starAnimationView.loopMode = .loop
      
//        animationView?.animationSpeed = 3.0
        loadingView.addSubview(starAnimationView)
        starAnimationView.play()
    }
}
