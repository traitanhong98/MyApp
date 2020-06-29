//
//  TardisScheduleInfoPopup.swift
//  FireBase001
//
//  Created by Hoang on 6/27/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisScheduleInfoPopup: TardisBasePopupViewController {

    @IBOutlet weak var containerView: TardisView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animateView = containerView
    }

}
