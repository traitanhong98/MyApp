//
//  Strings.swift
//  Heya
//
//  Created by TrungNV on 10/8/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Week
enum Weekday:String {
    case Mon = "Monday"
    case Tue = "Tueday"
    case Wed = "Wednesday"
    case Thu = "Thusday"
    case Fri = "Friday"
    case Sat = "Satuday"
    case Sun = "Sunday"
    case Err = "Err"
    static let allWeekdays = [Mon,Tue,Wed,Thu,Fri,Sat,Sun]
    static let allWeekdayWithSunFirst = [Sun,Mon,Tue,Wed,Thu,Fri,Sat]
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
    
    var index: Int {
        switch self {
        case .Mon:
            return 0
        case .Tue:
            return 1
        case .Wed:
            return 2
        case .Thu:
            return 3
        case .Fri:
            return 4
        case .Sat:
            return 5
        case .Sun:
            return 6
        default:
            return -666
        }
    }
}
// MARK: - Month
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

// MARK: - Setting
enum Setting {
    case userBlock
    case commonSetting
    case appInfo
    case devInfo
    case logOut
    case err
    
    static let allSetting = [userBlock, commonSetting, appInfo, devInfo]
    static let allLoggedInSetting = [userBlock,commonSetting,appInfo,devInfo,logOut]
    
    var image: UIImage {
        switch self {
        case .userBlock:
            return UIImage(named: "073-mixer") ?? UIImage()
        case .commonSetting:
            return UIImage(named: "073-mixer") ?? UIImage()
        case .appInfo:
            return UIImage(named: "013-star") ?? UIImage()
        case .devInfo:
            return UIImage(named: "012-stars") ?? UIImage()
        case .logOut:
            return UIImage(named: "056-doorknob") ?? UIImage()
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
            return "Nhà phát triển"
        case . logOut:
            return "Đăng xuất"
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
        case .logOut:
            return 4
        default:
            return -1
        }
    }
    
}
//MARK: - ViewMode
enum ViewMode {
    case normal,dayHour
}
// MARK: - LunarHoliday

enum LunarHoliday {
    case nguyenDan
    case nguyenTieu
    case hanThuc
    case gioTo
    case phatDan
    case doanNgo
    case vuLan
    case trungThu
    case trungCuu
    case thuongTan
    case haNguyen
    case taoQuan
    case none
    
    var nameVN: String {
        switch self {
        case .nguyenDan:
            return "Nguyên Đán"
            case .nguyenTieu:
            return "Nguyên Tiêu"
            case .hanThuc:
            return "Hàn Thực"
            case .gioTo:
            return "Giỗ tổ Hùng Vương"
            case .phatDan:
            return "Phật đản"
            case .doanNgo:
            return "Đoan Ngọ"
            case .vuLan:
            return "Vu Lan"
            case .trungThu:
            return "Trung Thu"
            case .trungCuu:
            return "Trùng Cửu"
            case .thuongTan:
            return "Thường Tân"
            case .haNguyen:
            return "Hạ Nguyên"
            case .taoQuan:
            return "Táo Quân"
        default:
            return ""
        }
    }
    
    static func getLunarHoliday(dayString: String) -> LunarHoliday{
        switch dayString {
        case "01-01":
            return .nguyenDan
            case "15-01":
            return .nguyenTieu
            case "03-03":
            return .hanThuc
            case "10-03":
            return .gioTo
            case "15-04":
            return .phatDan
            case "05-05":
            return .doanNgo
            case "15-07":
            return .vuLan
            case "15-8":
            return .trungThu
            case "09-09":
            return .trungCuu
            case "10-10":
            return .thuongTan
            case "15-10":
            return .haNguyen
            case "23-12":
            return .taoQuan
        default:
            return .none
        }
    }
}
enum Holiday {
    case newYear
    case valentine
    case doctorDayVN
    case womenDay
    case tncsHCM
    case foolApril
    case giaiPhongMienNam
    case quocTeLaoDong
    case chienThangDienBienPhu
    case ngayCuaMe
    case sinhNhatBac
    case quocTeThieuNhi
    case ngayCuaCha
    case ngayBaoChiVN
    case ngayGiaDinhVN
    case ngayDanSoTheGioi
    case ngayThuongBinhLietSi
    case thanhLapCongDoanVN
    case tongKhoiNghia
    case quocKhanh
    case thanhLapMatTranToQuocVN
    case quocTeNguoiCaoTuoi
    case giaiPhongThuDo
    case doanhNhanVN
    case phuNuVN
    case hallowen
    case phapLuatVN
    case nhaGiaoVietNam
    case thanhLapHoiChuThapDoVN
    case theGioiPhongChongAids
    case toanQuocKhangChien
    case giangSinh
    case thanhLapQuanDoiNhanDanVN
}
