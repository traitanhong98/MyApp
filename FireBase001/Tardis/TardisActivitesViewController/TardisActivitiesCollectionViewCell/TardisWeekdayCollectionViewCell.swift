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
    @IBOutlet weak var timeCollectionView: UICollectionView!
    //MARK:- Propeties
    var activity = [TardisActivity]()
    var weekDay: Weekday?
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        
        registerCell()
        setupCollectionView()
        exampleData()
    }
    //Similar to ViewDidAppear
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollToFirst()
    }
    //MARK: - IBAction
    
    @IBAction func addAction(_ sender: Any) {
    }
    //MARK:- Func
    func initView(){
        mainCellView.createShadow()
        self.contentView.bringSubviewToFront(addButton)
        self.mainCellView.sendSubviewToBack(timeCollectionView)
    }
    
    func bindData(weekDay: Weekday) {
        self.weekDay = weekDay
        weekdayLabel.text = weekDay.rawValue
        weekdayLabel.textColor = weekDay.weekColor
    }
    
    func scrollToFirst() {
        if CommonFunction.getCurrentDayOfWeek() == self.weekDay?.rawValue {
            let currentFloatTime = CommonFunction.getCurrenFloatTime()
            print(currentFloatTime)
            activityCollectionView.scrollRectToVisible(
                CGRect(origin:
                    CGPoint(x: activityCollectionView.frame.midX,
                            y: CGFloat(currentFloatTime)),
                       size: activityCollectionView.bounds.size),
                animated: false)
        } else {
            activityCollectionView.scrollRectToVisible(
                CGRect(origin:
                    CGPoint(x: activityCollectionView.frame.midX,
                            y: CGFloat(activity[0].startTime)),
                       size: activityCollectionView.bounds.size),
                animated: false)
        }
    }
    func calculatingHeightOfItem(startTime: Float,endTime: Float) -> Float{
        let startTimeHour = Float(Int(startTime / 100))
        let startTimeMinute = startTime - startTimeHour * 100
        let endTimeHour = Float(Int(endTime / 100))
        let endTimeMinute = endTime - endTimeHour * 100
        let heightResult = (endTimeHour - startTimeHour) * 100 + ((60 - startTimeMinute) / 60 ) * 100 + ((endTimeMinute - 60) / 60 ) * 100
        return heightResult
    }
    //Collectionview
    func registerCell() {
        //ActivityCollectionView
        activityCollectionView.register(UINib(nibName: "TardisActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisActivityCollectionViewCell")
        //TimeColectionView
        timeCollectionView.register(UINib(nibName: "TardisHourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisHourCollectionViewCell")
    }
    
    func setupCollectionView() {
        let activityCollectionViewFlowlayout = activityCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        activityCollectionViewFlowlayout.scrollDirection = .vertical
        initLayoutForCollectionView(activityCollectionView)
        let timeCollectionViewFlowLayout = timeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        timeCollectionViewFlowLayout.scrollDirection = .vertical
        initLayoutForCollectionView(timeCollectionView)
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
        switch collectionView {
        case activityCollectionView:
            return activity.count + 1
        case timeCollectionView:
            return 24
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case activityCollectionView:
            return 1
        case timeCollectionView:
            return 1
        default:
            return 0
        }
    }
    //CellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case activityCollectionView:
            if indexPath.section == 0 {
                return UICollectionViewCell()
            }
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisActivityCollectionViewCell", for: indexPath) as? TardisActivityCollectionViewCell {
                cell.bindData(data: activity[indexPath.section - 1])
                return cell
            } else {
                return UICollectionViewCell()
            }
        case timeCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisHourCollectionViewCell", for: indexPath) as? TardisHourCollectionViewCell {
                cell.bindData(hour: indexPath.section + 1)
                return cell
            } else {
                return UICollectionViewCell()
            }
        default:
            return UICollectionViewCell()
        }
    }
    //Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch collectionView {
        case activityCollectionView:
            var height: Float = 0
            if section == activity.count {
                height = calculatingHeightOfItem(startTime: activity[section - 1].endTime, endTime: 2400)
            } else if section == 0 {
                height = calculatingHeightOfItem(startTime: 0, endTime: activity[0].startTime)
            } else
            {
                height = calculatingHeightOfItem(startTime: activity[section - 1].endTime, endTime: activity[section].startTime)
            }
            print("Footer \(height)")
            return CGSize(width: activityCollectionView.frame.width, height: CGFloat(height))
        case timeCollectionView:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case activityCollectionView:
            print("Aloha \(indexPath.section)")
        case timeCollectionView:
            print("TimeCollectionView")
        default:
            print("Err")
        }
    }
}
extension TardisWeekdayCollectionViewCell:UICollectionViewDelegateFlowLayout {
    //SizeForItem
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case activityCollectionView:
            if indexPath.section == 0 {
                return CGSize(width: activityCollectionView.frame.size.width - 10, height: 0)
            }
            let height = calculatingHeightOfItem(startTime: activity[indexPath.section - 1].startTime, endTime: activity[indexPath.section - 1].endTime)
            print("ItemSize\(indexPath.section)--\(height)")
            return CGSize(width: activityCollectionView.frame.size.width - 10, height: CGFloat(height))
        case timeCollectionView:
            return CGSize(width: timeCollectionView.frame.width, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
//MARK:- UIScrollView
extension TardisWeekdayCollectionViewCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case timeCollectionView:
            activityCollectionView.contentOffset = timeCollectionView.contentOffset
        case activityCollectionView:
            timeCollectionView.contentOffset = activityCollectionView.contentOffset
        default:
            print("Err")
        }
    }
}
//Sample Data
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
