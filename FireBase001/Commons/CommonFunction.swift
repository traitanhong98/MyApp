//
//  CommonFunction.swift
//  FireBase001
//
//  Created by Hoang on 5/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import UserNotifications
class CommonFunction {
    // MARK: - Image
    static func resizeImage (image: UIImage,targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    // MARK: - Date-Time
    static func getCurrentDay() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        return result
    }
    static func getCurrenTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let result = formatter.string(from: date)
        return result
    }
    static func getCurrenFloatTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        let result = formatter.string(from: date)
        return result
    }
    static func getCurrentDayOfWeek() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let result = formatter.string(from: date)
        return result
    }
    static func calculateTimeDifference(from dateTime1: String, to dateTime2: String) -> [Float] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let dateAsString = dateTime1
        let date1 = dateFormatter.date(from: dateAsString)!
        
        let dateAsString2 = dateTime2
        let date2 = dateFormatter.date(from: dateAsString2)!
        
        let components : NSCalendar.Unit = [.minute, .hour]
        let difference = (Calendar.current as NSCalendar).components(components, from: date1, to: date2, options: [])
        
        let dateTimeDifferenceString = [Float(difference.hour ?? 0),Float(difference.minute ?? 0)]
        
        return dateTimeDifferenceString
        
    }
    // Lấy ra chuỗi ngày hiện tại
    static func getCurrentDateString(withFormat format:String) -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    // Lấy ra Ngày tháng cách ngày hiện tại
    // - xxx ngày
    static func getDateString(daysFromCurrentDate days: Int, withFormat format: String ) -> String {
        let currentCalendar = Calendar.current
        let result = currentCalendar.date(byAdding: .day, value: days, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: result ?? Date())
    }
    // - xxx tháng
    static func getDateString(monthsFromCurrentDate months: Int, withFormat format: String ) -> String {
        let currentCalendar = Calendar.current
        let result = currentCalendar.date(byAdding: .month, value: months, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: result ?? Date())
    }
    static func getDateString(fromDate date:Date,afterDays days:Int, andFormat format: String) -> String {
        let calendar = Calendar.current
        let result = calendar.date(byAdding: .day, value: days, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: result ?? Date())
    }
    static func getDate(fromDate date:Date,afterDays days:Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: days, to: date) ?? Date()
    }
    static func getDateString(fromDate date:Date, andFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date )
    }
    static func getDate(fromDateString dateString: String,withFormat format:String) -> Date {
        let Formater = DateFormatter()
        Formater.dateFormat = format
        return Formater.date(from: dateString) ?? Date()
    }
    static func getLunarDateString(fromDate date:Date, andFormat format: String) -> String {
        let lunarCalendar = Calendar(identifier: .chinese)
        let formater = DateFormatter()
        formater.calendar = lunarCalendar
        formater.dateFormat = format
        return formater.string(from: date)
    }
    static func getDateFromComponents(day: Int,month:Int,year:Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return calendar.date(from: components) ?? Date()
        
    }
    static func getMinute(fromTime time:String) -> Int {
        let timeArr = time.split(":")
        guard timeArr.count == 2 else { return 0 }
        return (Int(timeArr[0]) ?? 0) * 60 + (Int(timeArr[1]) ?? 0)
    }
    static func getTime(fromMinute minute: Int) -> String{
        var floatHour = Float(minute) / 60
        floatHour.round(.down)
        let hour = Int(floatHour)
        let minute = minute - hour * 60
        return "\(hour):\(minute)"
    }
    // Đổi định dạng ngày tháng của một chuỗi date
    static func changeDateFormat(dateString:String, fromFormat rawFormat: String, toFormat resultFormat: String) -> String {
        let rawFormater = DateFormatter()
        rawFormater.dateFormat = rawFormat
        let date = rawFormater.date(from: dateString)
        let resultFormater = DateFormatter()
        resultFormater.dateFormat = resultFormat
        return resultFormater.string(from: date ?? Date())
    }
    // MARK: - getSizeWithRatio
    static func getSizeWithRatio(width: Float, height: Float, ratio: Float) -> CGSize {
        return CGSize(width: CGFloat(width), height: CGFloat(height * ratio))
    }
    static func timeToFloat(time: String) -> Float {
        var result:Float = 0
        let timeArr = time.split(separator: ":")
        if timeArr.count == 2 {
            result += Float(timeArr[0]) ?? 0
            result += (Float(timeArr[1]) ?? 0) / 60
        }
        return result
    }
    // MARK: - IS_lOGIN
    static func isLogin() -> Bool{
        if UserInfo.userDidLogin() == false {
            return false
        } else {
            return true
        }
    }
    // MARK: - Annoucement
    //ShowNotice
    static func annoucement(title: String, message: String){
        OperationQueue.main.addOperation {
            guard let view = self.rootVC.view else {return}
            MBProgressHUD.hide(for: view, animated: true)
            let hub = MBProgressHUD.showAdded(to: view, animated: true)
            view.bringSubviewToFront(hub)
            hub.label.font = UIFont(name: "Helvetica", size: 16)
            hub.label.text = title
            hub.detailsLabel.font = UIFont(name: "Helvetica", size: 16)
            hub.detailsLabel.text = message
            hub.contentColor = .blue
            hub.mode = .text
            hub.removeFromSuperViewOnHide = true
            hub.isUserInteractionEnabled = false
            hub.hide(animated: true, afterDelay: 2)
        }
    }
    // MARK: - RootVC
    //Get RootVC
    static var rootVC:TardisMainTabbarViewController {
        get {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
              fatalError()
            }
            let rootVC = sceneDelegate.window?.rootViewController as! TardisMainTabbarViewController
            return rootVC
        }
    }
    static var appDelegate:AppDelegate {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate
        }
    }
    
    // MARK: - LoadingView
    static func showLoadingView() {
        let containerView = TardisLoadingView()
        rootVC.view.addSubview(containerView)
    }
    static func hideLoadingView() {
        for subview in rootVC.view.subviews {
            if subview.isKind(of: TardisLoadingView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    // MARK: - RecognizeDevice
    static func isIpad() -> Bool{
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    // MARK: - DownloadImage
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    // MARK: - UserNotification
    static func addNotification(activity: TardisActivityObject, weekDay: Int) {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Việc cần làm bạn ơi"
        content.body = "Sắp đến giờ \"\(activity.activityName)\""
        content.sound = UNNotificationSound.default
        var currentDate = ""
        if activity.startDate.count == 0 {
            currentDate = CommonFunction.getDateString(fromDate: Date(), andFormat: "dd/MM/yyyy")
        } else {
            currentDate = activity.startDate
        }
        let dateString = currentDate + " " + activity.startTime
        let dateTime = CommonFunction.getDate(fromDateString: dateString, withFormat: "dd/MM/yyyy hh:mm")
        
        let minutes = CommonFunction.getMinute(fromTime: activity.startTime) - 5
        var floatHour = Float(minutes) / 60
        floatHour.round(.down)
        let hour = Int(floatHour)
        let minute = minutes - hour * 60
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        var dateComponent = DateComponents()
        dateComponent.calendar = calendar
        dateComponent.timeZone = TimeZone.current
        dateComponent.year = 2020
        dateComponent.month = 07
        dateComponent.hour = hour
        dateComponent.minute = minute
        dateComponent.weekday = weekDay
        let myAlarmTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let identifier = activity.id
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: myAlarmTrigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                //TODO: Handle the error
                print("Noti eff")
                return
            }
            print("Noti Success")
        })
    }
    static func removeAllNoti() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    static func addNotiAtDate() {
        
    }
    static func addNoti() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "Body"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
