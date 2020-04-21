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
        //Connect to FirebaseDatabase
        let firRef = Database.database().reference(fromURL: "https://fir-001app.firebaseio.com/")
//        firRef.child("FirstData")
//        firRef.child("FirstData").setValue(["MyFirstValue":"HelloWorld!"])
        
        
        Auth.auth().createUser(withEmail: "myfirstemail@gmail.com", password: "abc123") { (result, err) in
            if let errCode = err {
                print("HelloSenpai: Error here\(errCode)")
            } else {
                print("HelloSenpai: Success here\(result?.description)")
            }
        }
        
        
        // Do any additional setup after loading the view.
    }


}

