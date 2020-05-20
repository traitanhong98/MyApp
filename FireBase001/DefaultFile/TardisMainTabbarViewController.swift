//
//  ViewController.swift
//  FireBase001
//
//  Created by Hoang on 4/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisMainTabbarViewController: UITabBarController {
    //Mark: -Var
    static var viewOfMainTabbar: UIView?
    //Mark: -LifeCycle
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
        
        //Update user value into a child
//        let userFirRef = firRef.child("users")
//        let value = ["name": "Hoang nm", "email":"myfirstemail@gmail.com"]
//              userFirRef.updateChildValues(value) { (err, ref) in
//                  if let errMess = err {
//                      print("HelloSenpai: Error here\(errMess)")
//                      return
//                  }
//
//                  print("HelloSenpai:Update Success fully")
//              }
//        // Do any additional setup after loading the view.
        initTabbar()
        TardisMainTabbarViewController.viewOfMainTabbar = self.view
        
    }
    //Mark: -Function
    func initTabbar() {
        //Icon
        let activitiesIcon = CommonFunction.resizeImage(image: UIImage(named: "advance-time")!, targetSize: CGSize(width: 30, height: 30))
        let threadIcon = CommonFunction.resizeImage(image: UIImage(named: "checked")!, targetSize: CGSize(width: 30, height: 30))
        let messageIcon = CommonFunction.resizeImage(image: UIImage(named: "speech-bubbles-and-pointer")!, targetSize: CGSize(width: 30, height: 30))
        let addonIcon = CommonFunction.resizeImage(image: UIImage(named: "sounds-between-headphones")!, targetSize: CGSize(width: 30, height: 30))
        let settingIcon = CommonFunction.resizeImage(image: UIImage(named: "sound-control")!, targetSize: CGSize(width: 30, height: 30))
        //Activities
        let homeVC = initVCForTabbar(type: TardisActivitiesViewController.self, vcStr: "TardisActivitiesViewController", title: "Weakly", icon: activitiesIcon)
        
        //Thread
        let historyVC = initVCForTabbar(type: TardisThreadViewController.self, vcStr: "TardisThreadViewController", title: "Thread", icon: threadIcon)
        
        //Chat
        let messageVC = initVCForTabbar(type: TardisChatViewController.self, vcStr: "TardisChatViewController", title: "Mesage", icon: messageIcon)
        
        //Addon
        
        let addonVC = initVCForTabbar(type: TardisAddonViewController.self, vcStr: "TardisAddonViewController", title: "Addon", icon: addonIcon)
        //Setting
        let settingVC = initVCForTabbar(type: TardisSettingViewController.self, vcStr: "TardisSettingViewController", title: "Setting", icon: settingIcon)
        self.setViewControllers([homeVC!, historyVC!, messageVC!,addonVC!, settingVC!], animated: true)
    }

}

