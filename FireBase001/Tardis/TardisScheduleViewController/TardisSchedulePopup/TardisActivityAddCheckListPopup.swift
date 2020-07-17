//
//  TardisActivityAddCheckListPopup.swift
//  FireBase001
//
//  Created by Hoang on 7/16/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisActivityAddCheckListPopupDelegate: class {
    func acceptAction(checkList: [TardisCheckListObject])
}

class TardisActivityAddCheckListPopup: TardisBasePopupViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeButton: TardisButton!
    @IBOutlet weak var activityTextView: UITextView!
    @IBOutlet weak var acceptButton: TardisButton!
    @IBOutlet weak var inputBlock: TardisView!
    
    weak var delegate: TardisActivityAddCheckListPopupDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        animateView = containerView
        // Do any additional setup after loading the view.
    }


    @IBAction func acceptAction(_ sender: Any) {
        view.endEditing(true)
        let activities = activityTextView.text
        guard let listActivities = activities?.split("-"),
            let delegate = delegate else { return }
        var checklist = [TardisCheckListObject]()
        for activity in listActivities {
            if activity.isEmpty {
                continue
            }
            let newActivity = TardisCheckListObject()
            newActivity.des = activity
            newActivity.status = false
            checklist.append(newActivity)
        }
        delegate.acceptAction(checkList: checklist)
        hide()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        hide()
    }
    
}
