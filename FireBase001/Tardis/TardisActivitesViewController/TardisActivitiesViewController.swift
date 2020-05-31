//
//  TardisActivitiesViewController.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import CenteredCollectionView
class TardisActivitiesViewController: BaseTabViewController {
    //MARK: -Outlet
    @IBOutlet weak var weekdayCollectionView: UICollectionView!
    @IBOutlet weak var containerView: TardisView!
    @IBOutlet weak var weekdayButtonCollectionView: UICollectionView!
    @IBOutlet weak var tardisWeekdayButtonFooterView: TardisView!
    @IBOutlet weak var leftOfWeekdayButtonView: NSLayoutConstraint!
    @IBOutlet weak var widthOfWeekdayFooter: NSLayoutConstraint!
    @IBOutlet weak var leftOfWeekdayFooterView: NSLayoutConstraint!
    //MARK: -Propeties
    var centeredWeekdayCollectionView: CenteredCollectionViewFlowLayout! = nil
    var sizeOfWeekdayButton: Float = 0
    var originPosXofFooter: CGFloat = 0
    var weekActivities = [[TardisActivity]]()
    var sizeRatio:Float = 1 {
        didSet {
            weekdayCollectionView.reloadData()
        }
    }
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exampleData()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        registerCell()
    }
    //MARK: -Func
    func registerCell() {
        //weekdayButtonCollectionView
        weekdayButtonCollectionView.register(UINib(nibName: "TardisWeekdayButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisWeekdayButtonCollectionViewCell")
        let weekdayButtonCollectionViewFlowLayout = weekdayButtonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        weekdayButtonCollectionViewFlowLayout.itemSize = CGSize(
            width: weekdayButtonCollectionView.frame.width/7,
            height: weekdayButtonCollectionView.frame.width/7
        )
        weekdayButtonCollectionViewFlowLayout.scrollDirection = .horizontal
        initLayoutForCollectionView(weekdayButtonCollectionView)
        weekdayButtonCollectionViewFlowLayout.minimumLineSpacing = 1
        //weekdayCollectionView
        weekdayCollectionView.register(UINib(nibName: "TardisWeekdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisWeekdayCollectionViewCell")
        self.centeredWeekdayCollectionView = weekdayCollectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout
        centeredWeekdayCollectionView.minimumLineSpacing = 10
        let width = Float(weekdayCollectionView.frame.width - 80)
        let height = Float(weekdayCollectionView.frame.height - 2)
        centeredWeekdayCollectionView.itemSize = CommonFunction.getSizeWithRatio(width: width,
                                                                                 height: height,
                                                                                 ratio: sizeRatio)
        initLayoutForCollectionView(weekdayCollectionView)
    }
    
    func initLayoutForCollectionView(_ collectionView: UICollectionView){
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupView() {
        self.sizeOfWeekdayButton = Float(weekdayButtonCollectionView.frame.width/7)
        self.originPosXofFooter = self.tardisWeekdayButtonFooterView.frame.origin.x
        self.widthOfWeekdayFooter.constant = weekdayButtonCollectionView.frame.width/7 - 3
    }
    //Di chuyển view Footer
    func footerViewAnimate(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            let pos = CGFloat((self.sizeOfWeekdayButton + 1) * Float(indexPath.row))
            self.tardisWeekdayButtonFooterView.frame = CGRect(
                x: self.originPosXofFooter + pos,
                y: self.tardisWeekdayButtonFooterView.frame.origin.y,
                width: self.tardisWeekdayButtonFooterView.frame.width,
                height: self.tardisWeekdayButtonFooterView.frame.height)
        }, completion: nil)
        
    }
}
//MARK: -CollectionViewDelegate
extension TardisActivitiesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case weekdayCollectionView:
            return 7
        case weekdayButtonCollectionView:
            return 7
        default:
            return 0
        }
    }
    //Cell for item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case weekdayCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisWeekdayCollectionViewCell", for: indexPath) as? TardisWeekdayCollectionViewCell {
                cell.bindData(weekDay: Weekday.getWeekday(index: indexPath.row), sizeRatio: sizeRatio, activities: weekActivities[indexPath.row])
                return cell
            } else {
                return UICollectionViewCell()
            }
        case weekdayButtonCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisWeekdayButtonCollectionViewCell", for: indexPath) as? TardisWeekdayButtonCollectionViewCell {
                cell.bindData(weekDay: Weekday.getWeekday(index: indexPath.row))
                return cell
            } else {
                return UICollectionViewCell()
            }
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case weekdayCollectionView:
            print("WeekdayTapped")
        case weekdayButtonCollectionView:
            weekdayCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        default:
            print("NotFound")
        }
    }
}
//MARK:- UIScrollView
extension TardisActivitiesViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch scrollView {
        case weekdayCollectionView:
           var visibleRect = CGRect()

            visibleRect.origin = weekdayCollectionView.contentOffset
            visibleRect.size = weekdayCollectionView.bounds.size

            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

            guard let indexPath = weekdayCollectionView.indexPathForItem(at: visiblePoint) else { return }

            footerViewAnimate(indexPath: indexPath)
        default:
            print("Hello")
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        switch scrollView {
        case weekdayCollectionView:
           var visibleRect = CGRect()

            visibleRect.origin = weekdayCollectionView.contentOffset
            visibleRect.size = weekdayCollectionView.bounds.size

            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

            guard let indexPath = weekdayCollectionView.indexPathForItem(at: visiblePoint) else { return }

            footerViewAnimate(indexPath: indexPath)
        default:
            print("Hello")
        }
    }
}

//Sample Data
extension TardisActivitiesViewController {
    func exampleData()  {
        //Sun
        let activity01 = TardisActivity(activityName: "Ăn sáng", startTime: 630, endTime: 700, note: "Ăn sáng", location: "Sun")
        let activity02 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity03 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity04 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity05 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity0 = [TardisActivity]()
        activity0.append(activity01)
        activity0.append(activity02)
        activity0.append(activity03)
        activity0.append(activity04)
        activity0.append(activity05)
        weekActivities.append(activity0)
        //Mon
        let activity11 = TardisActivity(activityName: "Ăn sáng", startTime: 600, endTime: 700, note: "Ăn sáng", location: "Mon")
        let activity12 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity13 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity14 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity15 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity1 = [TardisActivity]()
        activity1.append(activity11)
        activity1.append(activity12)
        activity1.append(activity13)
        activity1.append(activity14)
        activity1.append(activity15)
        weekActivities.append(activity1)
        //Tue
        let activity21 = TardisActivity(activityName: "Ăn sáng", startTime: 660, endTime: 700, note: "Ăn sáng", location: "Tue")
        let activity22 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity23 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity24 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity25 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity2 = [TardisActivity]()
        activity2.append(activity21)
        activity2.append(activity22)
        activity2.append(activity23)
        activity2.append(activity24)
        activity2.append(activity25)
        weekActivities.append(activity2)
        //Web
        let activity31 = TardisActivity(activityName: "Ăn sáng", startTime: 650, endTime: 700, note: "Ăn sáng", location: "Web")
        let activity32 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity33 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity34 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity35 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity3 = [TardisActivity]()
        activity3.append(activity31)
        activity3.append(activity32)
        activity3.append(activity33)
        activity3.append(activity34)
        activity3.append(activity35)
        weekActivities.append(activity3)
        //Thus
        let activity41 = TardisActivity(activityName: "Ăn sáng", startTime: 530, endTime: 700, note: "Ăn sáng", location: "Thus")
        let activity42 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity43 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity44 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity45 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity4 = [TardisActivity]()
        activity4.append(activity41)
        activity4.append(activity42)
        activity4.append(activity43)
        activity4.append(activity44)
        activity4.append(activity45)
        weekActivities.append(activity4)
        //Fri
        let activity51 = TardisActivity(activityName: "Ăn sáng", startTime: 600, endTime: 700, note: "Ăn sáng", location: "Fri")
        let activity52 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity53 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity54 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity55 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity5 = [TardisActivity]()
        activity5.append(activity51)
        activity5.append(activity52)
        activity5.append(activity53)
        activity5.append(activity54)
        activity5.append(activity55)
        weekActivities.append(activity5)
        //Sat
        let activity61 = TardisActivity(activityName: "Ăn sáng", startTime: 500, endTime: 700, note: "Ăn sáng", location: "Sat")
        let activity62 = TardisActivity(activityName: "Đi học", startTime: 715, endTime: 1100, note: "Ăn sáng", location: "")
        let activity63 = TardisActivity(activityName: "Nấu cơm", startTime: 1130, endTime: 1200, note: "Ăn sáng", location: "")
        let activity64 = TardisActivity(activityName: "Làm bếp", startTime: 1200, endTime: 1250, note: "Ăn sáng", location: "")
        let activity65 = TardisActivity(activityName: "Chơi game", startTime: 1300, endTime: 1330, note: "Ăn sáng", location: "")
        
        var activity6 = [TardisActivity]()
        activity6.append(activity61)
        activity6.append(activity62)
        activity6.append(activity63)
        activity6.append(activity64)
        activity6.append(activity65)
        weekActivities.append(activity6)
        
    }
}
