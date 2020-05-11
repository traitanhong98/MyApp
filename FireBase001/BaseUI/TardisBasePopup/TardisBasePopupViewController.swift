//
//  MVBasePopupViewController.swift
//  TestBase
//
//  Created by thaovm on 10/7/19.
//  Copyright © 2019 thaovm. All rights reserved.
//

import UIKit
import PureLayout

//@objc

@IBDesignable
@objc class TardisNewBasePopupViewController: MVModalBasePopupViewController {
    private var containerView: UIView?
    private var contentView: UIView?
    private var initialTouchPoint: CGPoint! = CGPoint.zero
    private var centerPoint: CGPoint!
    private var dismissAnimator: MVDismissAnimator?
    @objc public var closed: (() -> Void)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public convenience init(view cView: UIView) {
        self.init(nibName: nil, bundle: nil)
        contentView = cView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let contentView = self.contentView {
            if contentView.superview == nil {
                self.view.addSubview(contentView)
                let parentSize = UIScreen.main.bounds.size
                let contentSize = contentView.bounds.size
                let topInset = (parentSize.height - contentSize.height)/2.0
                let leftInset = (parentSize.width - contentSize.width)/2.0
                let bottomInset = topInset
                let rightInset = leftInset
                contentView.translatesAutoresizingMaskIntoConstraints = false
                contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset))

            }
        }
        if let interactView = self.getExpectedInteractView() {
            let swipeDownGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
            swipeDownGesture.cancelsTouchesInView = true
            interactView.addGestureRecognizer(swipeDownGesture)
        }
        self.dismissAnimator = MVDismissAnimator()
        self.dismissAnimator?.dismissed = {
            self.closed?()
            UIView.animate(withDuration: 0.2, animations: {
                self.dimView.alpha = 0.0
            }, completion: { (finished) in
                self.dimView.removeFromSuperview()
            })
        }
        
    }
    
    @objc public func show(onViewController presentVC: UIViewController?) {
        DispatchQueue.main.async {
            self.modalPresentationStyle = .overFullScreen
            self.interactor = MVInteractor()
            self.addDimBackground(presentVC?.view)
            presentVC?.present(self, animated: true, completion: {
                self.transitioningDelegate = self
            })
        }
        
    }
    
    var dimView: UIView!
    func addDimBackground(_ onView: UIView?) {
        guard let onView = onView else {
            return
        }
        self.dimView = UIView(frame: onView.bounds)
        self.dimView.backgroundColor = self.getDimBackgroundColor()?.withAlphaComponent(0.6)
        self.dimView.alpha = 0.0
        onView.addSubview(self.dimView)
        UIView.animate(withDuration: 0.5, animations: {
            self.dimView.alpha = 1.0
        })
    }
    
    
    public func getExpectedInteractView() -> UIView? {
        return self.contentView
    }
    
    public func getDimBackgroundColor() -> UIColor? {
        return UIColor.black
    }
    
    
}

extension MVNewBasePopupViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismissAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactor!.hasStarted ? interactor : nil
    }
}
