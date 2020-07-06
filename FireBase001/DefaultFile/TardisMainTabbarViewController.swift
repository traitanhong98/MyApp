//
//  ViewController.swift
//  FireBase001
//
//  Created by Hoang on 4/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
import MapKit
class TardisMainTabbarViewController: LGSideMenuController,UIGestureRecognizerDelegate {
    // MARK: - Propeties
    static var viewOfMainTabbar: UIView?
    var naviNotLogin = UINavigationController()
    var naviWeakly = UINavigationController()
    var naviSchedule = UINavigationController()
    var naviThread = UINavigationController()
    var naviMessage = UINavigationController()
    var naviAddon = UINavigationController()
    var currentVC = 0
    var arrayVC = [UINavigationController]()
    var mainTabBarController: UITabBarController?
    var naviMain = UINavigationController()
    var firstOpenApp = true
    let locationManager = CLLocationManager()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initTabbar()
        TardisMainTabbarViewController.viewOfMainTabbar = self.view
        configLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Mark: -Function
    func initTabbar() {
        setupLeftView()
        if !CommonFunction.isLogin() {
            setupNaviNotLogin()
            arrayVC = [naviNotLogin]
        } else {
            setupNaviWeakly()
            setupNaviSchedule()
            setupNaviThread()
            setupNaviMessage()
            setupNaviAddon()
            arrayVC = [naviWeakly, naviSchedule, naviThread, naviMessage,naviAddon]
        }
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
    // MARK: - LeftMenuView
    func setupLeftView() {
        self.leftViewController = TardisLeftMenuViewController()
        self.leftViewStatusBarStyle = .default
        self.leftViewWidth = self.view.frame.width / 3 * 2
    }
    
    // MARK: - CreateNavigationController
    func setupNaviNotLogin() {
           let notLoginIcon = CommonFunction.resizeImage(image: UIImage(named: "070-stopwatch")!, targetSize: CGSize(width: 30, height: 30))
           //Activities
           let notLoginVC = initVCForTabbar(type: TardisNotLoginViewController.self, vcStr: "TardisNotLoginViewController", title: "Require Login", icon: notLoginIcon)
           //Navigation
           naviNotLogin = UINavigationController(rootViewController: notLoginVC!)
           naviNotLogin.interactivePopGestureRecognizer?.delegate = self
           naviNotLogin.isNavigationBarHidden = true
       }
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
        let scheduleVC = initVCForTabbar(type: TardisScheduleViewController.self, vcStr: "TardisScheduleViewController", title: "Schedule", icon: scheduleIcon)
        
        //Navigation
        naviSchedule = UINavigationController(rootViewController: scheduleVC!)
        naviSchedule.interactivePopGestureRecognizer?.delegate = self
        naviSchedule.isNavigationBarHidden = true
    }
    
    func setupNaviThread() {
        let threadIcon = CommonFunction.resizeImage(image: UIImage(named: "013-team")!, targetSize: CGSize(width: 30, height: 30))
        //Thread
        let threadVC = initVCForTabbar(type: TardisChannelViewController.self, vcStr: "TardisChannelViewController", title: "Channels", icon: threadIcon)
 
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
    func doLogout() {
        let popup = TardisPopup()
        popup.settingPoup(title: "Thông báo",
                          description: "Bạn có muốn đăng xuất",
                          isAcceptButton: true,
                          isBackButton: true)
        popup.delegate = self
        hideLeftViewAnimated()
        popup.show()
    }
    func hileLeftView(completion: @escaping () -> Void) {
        self.hideLeftView(animated: true, completionHandler: completion)
    }
    
    func showUserInfo() {
        hideLeftViewAnimated()
        let userInfoBlock = TardisUserInfoViewController()
        naviMain.pushViewController(userInfoBlock, animated: true)
    }
    func configLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
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
    func didShowLeftView(_ leftView: UIView, sideMenuController: LGSideMenuController) {
        if let menuVC = self.leftViewController as? TardisLeftMenuViewController {
            menuVC.reloadData()
        }
    }

}

extension TardisMainTabbarViewController: TardisPopupDelegate {
    func acceptAction() {
        TardisBaseRequestModel.shared.doLogOut()
    }
    
    func backAction() {
    }
}
extension TardisMainTabbarViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let location = Location()
        location.latitude = locValue.latitude
        location.longtitude = locValue.longitude
        TardisBaseRequestModel.shared.updateUserLocation(location)
    }
}
