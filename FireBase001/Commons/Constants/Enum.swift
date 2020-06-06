//
//  Strings.swift
//  Heya
//
//  Created by TrungNV on 10/8/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit

enum Weekday:String {
    case Sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Web = "Web"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
    case Err = "Err"
    static let allWeekdays = [Sun,Mon,Tue,Web,Thu,Fri,Sat]
    
    static func getWeekday(index: Int)-> Weekday {
        switch index {
        case 0,7:
            return Sun
        case 1:
            return Mon
        case 2:
            return Tue
        case 3:
            return Web
        case 4:
            return Thu
        case 5:
            return Fri
        case 6,-1:
            return Sat
        default:
            return Err
        }
    }
    
    var weekColor: UIColor{
        switch self {
        case .Sun:
            return UIColor.yellow
        case .Mon:
            return UIColor.red
        case .Tue:
            return UIColor.green
        case .Web:
            return UIColor.blue
        case .Thu:
            return UIColor.orange
        case .Fri:
            return UIColor.purple
        case .Sat:
            return UIColor.cyan
        default:
            return UIColor.black
        }
    }
}

enum Month:Int {
    case Jan = 0 ,Feb, Mar, Apr, May, Jun,
    Jul, Aug, Sep, Oct, Nov, Dec
}
enum Setting:String {
    case userBlock      = "Người dùng"
    case userInfo       = "Thông tin cá nhân"
    case commonSetting  = "Cài đặt chung"
    case appInfo        = "Thông tin ứng dụng"
    case devInfo        = "Giới thiệu nhà phát triển"
    case err            = "err"
    
    static let allSetting = [userBlock, userInfo, commonSetting, appInfo, devInfo]
    
    static func getSetting(index: Int)-> Setting {
        switch index {
        case 0:
            return userBlock
        case 1:
            return userInfo
        case 2:
            return commonSetting
        case 3:
            return appInfo
        case 4:
            return devInfo
        default:
            return err
        }
    }
    
    var image: UIImage {
        switch self {
        case .userBlock:
            return UIImage()
        case .userInfo:
            return UIImage(systemName: "person.crop.circle.fill") ?? UIImage()
        case .commonSetting:
            return UIImage(named: "ic_setting_25") ?? UIImage()
        case .appInfo:
            return UIImage(systemName: "info") ?? UIImage()
        case .devInfo:
            return UIImage(systemName: "star.circle") ?? UIImage()
        default:
            return UIImage()
        }
    }
    
    var name: String {
        switch self {
        case .userBlock:
            
            return "Người dùng"
        case .userInfo:
            if CommonFunction.isLogin() {
                return "Thông tin cá nhân"
            } else {
                return "Đăng nhập"
            }
        case .commonSetting:
            return "Cài đặt chung"
        case .appInfo:
            return "Thông tin ứng dụng"
        case .devInfo:
            return "Giới thiệu nhà phát triển"
        default:
            return "Err"
        }
    }
    
    var settingIndex: Int {
        switch self {
        case .userBlock:
            return 0
        case .userInfo:
            return 1
        case .commonSetting:
            return 2
        case .appInfo:
            return 3
        case .devInfo:
            return 4
        default:
            return -1
        }
    }
    
}
//MARK: - UI
enum ViewMode {
    case normal,dayHour
}
