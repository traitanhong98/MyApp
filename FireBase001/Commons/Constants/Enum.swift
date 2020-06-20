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
    case Mon = "Monday"
    case Tue = "Tueday"
    case Wed = "Wednesday"
    case Thu = "Thusday"
    case Fri = "Friday"
    case Sat = "Satuday"
    case Sun = "Sunday"
    case Err = "Err"
    static let allWeekdays = [Sun,Mon,Tue,Wed,Thu,Fri,Sat]
    
    static func getWeekday(index: Int)-> Weekday {
        switch index {
        case 0,7:
            return Mon
        case 1:
            return Tue
        case 2:
            return Wed
        case 3:
            return Thu
        case 4:
            return Fri
        case 5:
            return Sat
        case 6,-1:
            return Sun
        default:
            return Err
        }
    }
    
    var weekColor: UIColor{
        switch self {
        case .Mon:
            return UIColor.yellow
        case .Tue:
            return UIColor.red
        case .Wed:
            return UIColor.green
        case .Thu:
            return UIColor.blue
        case .Fri:
            return UIColor.orange
        case .Sat:
            return UIColor.purple
        case .Sun:
            return UIColor.cyan
        default:
            return UIColor.black
        }
    }
    
    var sortName: String{
        switch self {
        case .Mon:
            return "Mon"
        case .Tue:
            return "Tue"
        case .Wed:
            return "Wed"
        case .Thu:
            return "Thu"
        case .Fri:
            return "Fri"
        case .Sat:
            return "Sat"
        case .Sun:
            return "Sun"
        default:
            return "Err"
        }
    }
}

enum Month {
    case Jan ,Feb, Mar, Apr, May, Jun,
    Jul, Aug, Sep, Oct, Nov, Dec
    
    static let allMonth = [Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec]
    
    var nameVN: String {
        switch self {
        case .Jan:
            return "Tháng Một"
        case .Feb:
            return "Tháng Hai"
        case .Mar:
            return "Tháng Ba"
        case .Apr:
            return "Tháng Tư"
        case .May:
            return "Tháng Năm"
        case .Jun:
            return "Tháng Sáu"
        case .Jul:
            return "Tháng Bảy"
        case .Aug:
            return "Tháng Tám"
        case .Sep:
            return "Tháng Chín"
        case .Oct:
            return "Tháng Mười"
        case .Nov:
            return "Tháng Mười Một"
        case .Dec:
            return "Tháng Mười Hai"
        }
    }
    
    var index: Int {
        switch self {
        case .Jan:
            return 0
        case .Feb:
            return 1
        case .Mar:
            return 2
        case .Apr:
            return 3
        case .May:
            return 4
        case .Jun:
            return 5
        case .Jul:
            return 6
        case .Aug:
            return 7
        case .Sep:
            return 8
        case .Oct:
            return 9
        case .Nov:
            return 10
        case .Dec:
            return 11
        }
    }
    var numberOfDay:Int {
        switch self {
        case .Jan,.Mar,.May,.Jul,.Aug,.Oct,.Dec:
            return 31
        case .Feb:
            return -1 // Check Year
        default:
            return 30
        }
    }
}
enum Setting:String {
    case userBlock      = "Người dùng"
    case commonSetting  = "Cài đặt chung"
    case appInfo        = "Thông tin ứng dụng"
    case devInfo        = "Giới thiệu nhà phát triển"
    case err            = "err"
    
    static let allSetting = [userBlock, commonSetting, appInfo, devInfo]
    
    static func getSetting(index: Int)-> Setting {
        switch index {
        case 0:
            return userBlock
        case 1:
            return commonSetting
        case 2:
            return appInfo
        case 3:
            return devInfo
        default:
            return err
        }
    }
    
    var image: UIImage {
        switch self {
        case .userBlock:
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
        case .commonSetting:
            return 1
        case .appInfo:
            return 2
        case .devInfo:
            return 3
        default:
            return -1
        }
    }
    
}
//MARK: - UI
enum ViewMode {
    case normal,dayHour
}
