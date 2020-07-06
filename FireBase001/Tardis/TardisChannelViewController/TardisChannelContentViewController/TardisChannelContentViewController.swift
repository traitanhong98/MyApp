//
//  TardisChannelContentViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
enum TardisChannelPage {
    case chat
    case checkList
    case info
    
    var tag: Int {
        switch self {
        case .chat:
            return 0
        case .checkList:
            return 1
        case .info:
            return 2
        }
    }
}


class TardisChannelContentViewController: UIViewController {

    @IBOutlet weak var bottomOfMenuView: NSLayoutConstraint!
    @IBOutlet weak var leftOfMenuView: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chatButton: TardisButton!
    @IBOutlet weak var checkListButton: TardisButton!
    @IBOutlet weak var infoButton: TardisButton!
    @IBOutlet weak var pageView: UIView!
    // MARK: - Propety
    var pageViewController: UIPageViewController?
    var listVC = [UIViewController]()
    var currentChannel: TardisChannelObject!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    func setupView () {
        self.titleLabel.text = currentChannel.channelName
        // PageView
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        guard let pageVC = pageViewController else {return}
        pageVC.delegate = self
        // Chat
        let chatVC = TardisNewChatViewController()
        chatVC.currentChannel = currentChannel
        chatVC.page = .chat
        chatVC.view.frame = pageView.bounds
        listVC.append(chatVC)
        // CheckList
        let checkListVC = TardisChannelCheckListViewController(nibName: "TardisChannelCheckListViewController",
                                                               bundle: nil)
        checkListVC.page = .checkList
        checkListVC.view.frame = pageView.bounds
        checkListVC.currentChannel = currentChannel
        listVC.append(checkListVC)
        // Info
        let infoVC = TardisChannelInfoViewController(nibName: "TardisChannelInfoViewController",
                                                     bundle: nil)
        infoVC.page = .info
        listVC.append(infoVC)
        
        pageVC.setViewControllers([listVC[0]],
                                  direction: .forward,
                                  animated: false,
                                  completion: nil)
        pageVC.dataSource = self
        addChild(pageVC)
        pageView.addSubview(pageVC.view)
        pageVC.view.frame = pageView.bounds
        pageVC.didMove(toParent: self)
    }
    func setCheckedButton(index: Int) {
        
    }
    // Lấy ra Viewcontroller trong PageView theo Index tương ứng
       func viewControllerAtIndex(_ index: Int) -> UIViewController? {
           if listVC.count == 0 || index >= listVC.count {
               return nil
           }
           return listVC[index]
       }
    func indexOfViewController(_ viewController: UIViewController) -> Int {
        return listVC.firstIndex(of: viewController) ?? NSNotFound
    }
    
    @IBAction func panGestureAction(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {
            return
        }
        let translation = sender.translation(in: view)
        leftOfMenuView.constant += translation.x
        bottomOfMenuView.constant -= translation.y
        sender.setTranslation(.zero, in: view)
    }
    @IBAction func chatAction(_ sender: Any) {
        guard let pageVC = pageViewController else {return}
        pageVC.setViewControllers([viewControllerAtIndex(TardisChannelPage.chat.tag)!],
        direction: .reverse,
        animated: false,
        completion: nil)
    }
    @IBAction func checkListAction(_ sender: Any) {
        guard let pageVC = pageViewController else {return}
        pageVC.setViewControllers([viewControllerAtIndex(TardisChannelPage.checkList.tag)!],
        direction: .reverse,
        animated: false,
        completion: nil)
    }
    @IBAction func infoAction(_ sender: Any) {
        guard let pageVC = pageViewController else {return}
        pageVC.setViewControllers([viewControllerAtIndex(TardisChannelPage.info.tag)!],
        direction: .reverse,
        animated: false,
        completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - UIPageViewControllerDelegate
extension TardisChannelContentViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // Xử lý UI - UX của pageView
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == listVC.count {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool){
        if !completed {
            return
        }
        // Nếu đổi page thì SegmentView cũng cần đổi theo
        setCheckedButton(index: indexOfViewController((pageViewController.viewControllers?.first)!))
    }
}
