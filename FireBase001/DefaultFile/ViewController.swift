//
//  ViewController.swift
//  FireBase001
//
//  Created by Hoang on 4/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

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
    }


}

