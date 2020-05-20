//
//  TardisRootViewController.swift
//  FireBase001
//
//  Created by Hoang on 5/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisRootViewController: UIViewController {
    //Mark: -Propeties
    @IBOutlet weak var tardisTabbar: UITabBar!
    
    @IBOutlet weak var headerLabel: TardisLabel!
    @IBOutlet weak var TardisHeaderView: UIView!
    
    @IBOutlet weak var tardisMainCollectionView: UICollectionView!
    
    var weaklyTab = UITabBarItem()
    var threadTab = UITabBarItem()
    var messageTab = UITabBarItem()
    var extensionTab = UITabBarItem()
    var settingTab = UITabBarItem()
    //Mark: -Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        setupUI()
        
    }

    //Mark: -Func
    func setupTabbar() {
        tardisTabbar.items?.removeAll()
        //Weakly
        let weaklyIcon = CommonFunction.resizeImage(image: UIImage(named: "advance-time")!, targetSize: CGSize(width: 30, height: 30))
        weaklyTab = UITabBarItem(title: "Weekly", image: weaklyIcon, selectedImage: nil)
        //Thread
        let threadIcon = CommonFunction.resizeImage(image: UIImage(named: "checked")!, targetSize: CGSize(width: 30, height: 30))
        threadTab = UITabBarItem(title: "Thread", image: threadIcon, selectedImage: nil)
        //Message
        let messageIcon = CommonFunction.resizeImage(image: UIImage(named: "speech-bubbles-and-pointer")!, targetSize: CGSize(width: 30, height: 30))
        messageTab = UITabBarItem(title: "Message", image: messageIcon, selectedImage: nil)
        //Extension
        let extensionIcon = CommonFunction.resizeImage(image: UIImage(named: "sounds-between-headphones")!, targetSize: CGSize(width: 30, height: 30))
        extensionTab = UITabBarItem(title: "Extension", image: extensionIcon, selectedImage: nil)
        //Setting
        let settingIcon = CommonFunction.resizeImage(image: UIImage(named: "sound-control")!, targetSize: CGSize(width: 30, height: 30))
        settingTab = UITabBarItem(title: "Setting", image: settingIcon, selectedImage: nil)

        //AddItem
        tardisTabbar.items?.append(weaklyTab)
        tardisTabbar.items?.append(threadTab)
        tardisTabbar.items?.append(messageTab)
        tardisTabbar.items?.append(extensionTab)
        tardisTabbar.items?.append(settingTab)
        //UI
        tardisTabbar.backgroundColor = UIColor.white
        tardisTabbar.selectedItem = tardisTabbar.items?.first
        tardisTabbar.delegate = self
    }
    
    func setupUI(){
        TardisHeaderView.createShadow()
    }
    
    func registerCell(){
        
    }
}
//Mark: -UITabbarDelegate
extension TardisRootViewController:UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case weaklyTab:
            headerLabel.text = "Tardis Weekly Schedule"
            return
        case threadTab:
            headerLabel.text = "Tardis Thread"
            return
        case messageTab:
            headerLabel.text = "Tardis Messaging"
            return
        case extensionTab:
            headerLabel.text = "Tardis Extension"
            return
        case settingTab:
            headerLabel.text = "Tardis Setting"
            return
        default:
            return
        }
    }
}
