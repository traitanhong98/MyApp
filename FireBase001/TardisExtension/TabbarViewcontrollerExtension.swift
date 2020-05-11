//
//  TabbarViewcontrollerExtension.swift
//  Heya
//
//  Created by TrungNV on 10/8/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController{
    func initVCForTabbar<T: BaseTabViewController>(type: T.Type, vcStr: String, title: String, icon: UIImage) -> T? {
        let item = UITabBarItem()
        item.title = title
        item.image = icon

        let viewController = T(nibName: vcStr, bundle: nil)
        viewController.tabBarItem = item
        
        return viewController
    }

}
