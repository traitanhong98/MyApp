//
//  TardisWeekdayCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisWeekdayCollectionViewCell: UICollectionViewCell {
    //MARK:- Outlet
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    //MARK:- Propeties
    var activity = [TardisActivity]()
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        
        registerCell()
        setupCollectionView()
        exampleData()
    }
    //MARK:- Func
    func initView(){
        mainCellView.createShadow()
        self.contentView.bringSubviewToFront(addButton)
    }
    
    func bindData(weekDay: Weekday) {
        weekdayLabel.text = weekDay.rawValue
        weekdayLabel.textColor = weekDay.weekColor
    }
    //Collectionview
    func registerCell() {
        activityCollectionView.register(UINib(nibName: "TardisActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisActivityCollectionViewCell")
    }
    
    func setupCollectionView() {
        let activityCollectionViewFlowlayout = activityCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        activityCollectionViewFlowlayout.scrollDirection = .vertical
        initLayoutForCollectionView(activityCollectionView)
    }
    
    func initLayoutForCollectionView(_ collectionView: UICollectionView){
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension TardisWeekdayCollectionViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           if collectionView == activityCollectionView {
            return activity.count - 1
           }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisActivityCollectionViewCell", for: indexPath) as? TardisActivityCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var height: Float = 0
        if section == activity.count - 1 {
            height = 2400 - activity[section].endTime
        } else {
            height = activity[section + 1].startTime - activity[section].endTime
        }
        return CGSize(width: activityCollectionView.frame.width, height: CGFloat(height))
    }
}
extension TardisWeekdayCollectionViewCell:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = activity[indexPath.section].endTime - activity[indexPath.section].startTime
        return CGSize(width: activityCollectionView.frame.size.width - 10, height: CGFloat(height))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension TardisWeekdayCollectionViewCell {
    func exampleData()  {
        let activity1 = TardisActivity(activityName: "Ăn sáng", startTime: 630, endTime: 700, note: "Ăn sáng", location: "")
        let activity2 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity3 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity4 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity5 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        activity.append(activity1)
        activity.append(activity2)
        activity.append(activity3)
        activity.append(activity4)
        activity.append(activity5)
    }
}
