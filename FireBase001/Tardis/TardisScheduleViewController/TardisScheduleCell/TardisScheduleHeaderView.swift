//
//  TardisScheduleHeaderView.swift
//  FireBase001
//
//  Created by Hoang on 6/25/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisScheduleHeaderView: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    var headerTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        headerLabel.text = headerTitle
    }
}
