//
//  ViewController.swift
//  FireBase001
//
//  Created by Hoang on 4/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisMainTabbarViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    // MARK: - Propeties
    static var viewOfMainTabbar: UIView?
    var naviWeakly = UINavigationController()
    var naviSchedule = UINavigationController()
    var naviThread = UINavigationController()
    var naviMessage = UINavigationController()
    var naviAddon = UINavigationController()
    var currentVC = 0
    var arrayVC = [UINavigationController]()
    var mainTabBarController: UITabBarController?
    var naviMain = UINavigationController()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        //Connect to FirebaseDatabase
//        let firRef = Database.database().reference(fromURL: "https://fir-001app.firebaseio.com/")
//        firRef.child("FirstData")
//        firRef.child("FirstData").setValue(["MyFirstValue":"HelloWorld!"])
        
        //Đã tạo user xong
//        Auth.auth().createUser(withEmail: "myfirstemail@gmail.com", password: "abc123") { (result, err) in
//            if let errCode = err {
//                print("HelloSenpai: Error here\(errCode)")
//            } else {
//                print("HelloSenpai: Success here\(result?.description)")
//            }
//        }
        
        //Update user value
//        let value = ["name": "Hoang nm", "email":"myfirstemail@gmail.com"]
//        firRef.updateChildValues(value) { (err, ref) in
//            if let errMess = err {
//                print("HelloSenpai: Error here\(errMess)")
//                return
//            }
//
//            print("HelloSenpai:Update Success fully")
//        }
        

        initTabbar()
        TardisMainTabbarViewController.viewOfMainTabbar = self.view
        
    }
    //Mark: -Function
    func initTabbar() {
        setupNaviWeakly()
        setupNaviSchedule()
        setupNaviThread()
        setupNaviMessage()
        setupNaviAddon()
//        if !CommonFunction.isLogin() {
//            self.setViewControllers([naviWeakly!,naviSchedule!,naviAddon!], animated: true)
//        } else {
            arrayVC = [naviWeakly, naviSchedule, naviThread, naviMessage,naviAddon]
//        }
        if mainTabBarController == nil {
            mainTabBarController = UITabBarController()
            
            naviMain = UINavigationController.init(rootViewController: mainTabBarController!)
            naviMain.isNavigationBarHidden = true
        }
        if ((mainTabBarController?.presentedViewController) != nil) {
            mainTabBarController?.dismiss(animated: false, completion: nil)
        }
        mainTabBarController!.setViewControllers(arrayVC, animated: true)
        self.rootViewController = naviMain
        mainTabBarController?.delegate = self
        self.delegate = self
    }
    // MARK: - CreateNavigationController
    func setupNaviWeakly() {
        let activitiesIcon = CommonFunction.resizeImage(image: UIImage(named: "070-stopwatch")!, targetSize: CGSize(width: 30, height: 30))
        //Activities
        let weaklyVC = initVCForTabbar(type: TardisActivitiesViewController.self, vcStr: "TardisActivitiesViewController", title: "Weakly", icon: activitiesIcon)
        //Navigation
        naviWeakly = UINavigationController(rootViewController: weaklyVC!)
        naviWeakly.interactivePopGestureRecognizer?.delegate = self
        naviWeakly.isNavigationBarHidden = true
    }
    
    func setupNaviSchedule() {
        let scheduleIcon = CommonFunction.resizeImage(image: UIImage(named: "034-schedule-1")!, targetSize: CGSize(width: 30, height: 30))
        //Schedule
        let scheduleVC = initVCForTabbar(type: TardisThreadViewController.self, vcStr: "TardisThreadViewController", title: "Schedule", icon: scheduleIcon)
        //Navigation
        naviSchedule = UINavigationController(rootViewController: scheduleVC!)
        naviSchedule.interactivePopGestureRecognizer?.delegate = self
        naviSchedule.isNavigationBarHidden = true
    }
    
    func setupNaviThread() {
        let threadIcon = CommonFunction.resizeImage(image: UIImage(named: "013-team")!, targetSize: CGSize(width: 30, height: 30))
        //Thread
        let threadVC = initVCForTabbar(type: TardisThreadViewController.self, vcStr: "TardisThreadViewController", title: "Thread", icon: threadIcon)
        //Navigation
        naviThread = UINavigationController(rootViewController: threadVC!)
        naviThread.interactivePopGestureRecognizer?.delegate = self
        naviThread.isNavigationBarHidden = true
    }
    
    func setupNaviMessage() {
        let messageIcon = CommonFunction.resizeImage(image: UIImage(named: "speech-bubbles-and-pointer")!, targetSize: CGSize(width: 30, height: 30))
        //Chat
        let messageVC = initVCForTabbar(type: TardisChatViewController.self, vcStr: "TardisChatViewController", title: "Mesage", icon: messageIcon)
        //Navigation
        naviMessage = UINavigationController(rootViewController: messageVC!)
        naviMessage.interactivePopGestureRecognizer?.delegate = self
        naviMessage.isNavigationBarHidden = true
    }
    
    func setupNaviAddon() {
        let addonIcon = CommonFunction.resizeImage(image: UIImage(named: "sounds-between-headphones")!, targetSize: CGSize(width: 30, height: 30))
        //Addon
        let addonVC = initVCForTabbar(type: TardisAddonViewController.self, vcStr: "TardisAddonViewController", title: "Addon", icon: addonIcon)
        //Navigation
        naviAddon = UINavigationController(rootViewController: addonVC!)
        naviAddon.interactivePopGestureRecognizer?.delegate = self
        naviAddon.isNavigationBarHidden = true
    }
    
    func openLogin() {
        let loginView = TardisLoginViewController()
        naviMain.pushViewController(loginView, animated: true)
    }
    
}

extension TardisMainTabbarViewController {
    func initVCForTabbar<T: BaseTabViewController>(type: T.Type, vcStr: String, title: String, icon: UIImage) -> T? {
        let item = UITabBarItem()
        item.title = title
        item.image = icon

        let viewController = T(nibName: vcStr, bundle: nil)
        viewController.tabBarItem = item
        
        return viewController
    }
}

// MARK: - UITabBarControllerDelegate
extension TardisMainTabbarViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
}

// MARK: - LGSideMenuDelegate
extension TardisMainTabbarViewController: LGSideMenuDelegate{
    
}
