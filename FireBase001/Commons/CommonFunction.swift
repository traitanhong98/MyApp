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
class CommonFunction {
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
    //Date-Time
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
    //GetSize
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
    //IS_lOGIN
    static func isLogin() -> Bool{
        if UserInfo.userDidLogin() == false {
            return false
        } else {
            return true
        }
    }
    //ShowNotice
    static func annoucement(title: String, message: String){
        OperationQueue.main.addOperation {
            guard let view = self.rootVC.naviMain.view else {return}
            MBProgressHUD.hide(for: view, animated: true)
            let hub = MBProgressHUD.showAdded(to: view, animated: true)
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
    
    //LoadingView
    static func showLoadingView() {
        let animationView = AnimationView(name: "infinityLoading")
        animationView.frame.size = CGSize(width: 300, height: 300)
        animationView.center = CGPoint(x: rootVC.view.frame.width / 2,
                                       y: rootVC.view.frame.height / 2)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.5
        rootVC.view.addSubview(animationView)
        
        animationView.play()
    }
    static func hideLoadingView() {
        for subview in rootVC.view.subviews {
            if subview.isKind(of: AnimationView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    // MARK: - RecognizeDevice
    static func isIpad() -> Bool{
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    // MARK: - ShowImagePicker
//    static func createImagePicker() -> UIImagePickerController {
//        
//    }
    
    // MARK: - DownloadImage
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
