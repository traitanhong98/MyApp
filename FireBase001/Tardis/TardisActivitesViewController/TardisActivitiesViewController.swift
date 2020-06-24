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
    @IBOutlet weak var viewModeButton: UIButton!
    @IBOutlet weak var sizeRatioButton: UIButton!
    //MARK: -Propeties
    var dataModel = TardisActivitiesDataModel.shared
    var centeredWeekdayCollectionView: CenteredCollectionViewFlowLayout?
    var weekdayButtonCollectionViewFlowLayout: UICollectionViewFlowLayout?
    var sizeOfWeekdayButton: Float = 0
    var originPosXofFooter: CGFloat = 0
    var weekActivities = [[TardisActivityObject]]()
    var sizeRatio:Float = 1 {
        didSet {
            setupCell()
            weekdayCollectionView.reloadData()
        }
    }
    var viewMode = ViewMode.dayHour {
        didSet{
            weekdayCollectionView.reloadData()
        }
    }
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
//        exampleData()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        registerCell()
    }
    //MARK: - Func
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
        //weekdayCollectionView
        weekdayCollectionView.register(UINib(nibName: "TardisWeekdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisWeekdayCollectionViewCell")
        self.centeredWeekdayCollectionView = weekdayCollectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout
        setupCell()
        centeredWeekdayCollectionView!.minimumLineSpacing = 10
        initLayoutForCollectionView(weekdayCollectionView)
    }
    func setupCell() {
        let width = Float(weekdayCollectionView.frame.width - 80) * sizeRatio
        let height = Float(weekdayCollectionView.frame.height - 2)
        let itemSize = CommonFunction.getSizeWithRatio(width: width,
                                                       height: Float(height),
                                                       ratio: sizeRatio)
        centeredWeekdayCollectionView!.itemSize = itemSize
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
    func loadData() {
        dataModel.loadActivities { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Load dữ liệu thành công")
                self.weekdayCollectionView.reloadData()
            } else {
                CommonFunction.annoucement(title: "", message: "Load dữ liệu thất bại")
            }
        }
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
    //MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        let popup = TardisAddNewActivityPopup()
        popup.delegate = self
        popup.show()
    }
    @IBAction func leftMenuButton(_ sender: Any) {
        CommonFunction.rootVC.showLeftViewAnimated()
    }
    
    @IBAction func viewModeButtonTapped(_ sender: Any) {
        if self.viewMode == .normal {
            self.viewMode = .dayHour
            self.viewModeButton.setImage(UIImage(systemName: "24.circle"), for: .normal)
        } else {
            self.viewMode = .normal
             self.viewModeButton.setImage(UIImage(systemName: "rectangle.3.offgrid"), for: .normal)
            self.weekdayCollectionView.reloadData()
        }
    }
    
}
//MARK: -CollectionViewDelegate
extension TardisActivitiesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case weekdayCollectionView:
            return 1
        case weekdayButtonCollectionView:
            return 7
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case weekdayCollectionView:
            return 7
        case weekdayButtonCollectionView:
            return 1
        default:
            return 0
        }
    }
    //Cell for item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case weekdayCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisWeekdayCollectionViewCell", for: indexPath) as? TardisWeekdayCollectionViewCell {
                cell.bindData(weekDay: Weekday.getWeekday(index: indexPath.row), sizeRatio: sizeRatio, activities: dataModel.dailyActivityArray[indexPath.row],viewMode: viewMode)
                return cell
            } else {
                return UICollectionViewCell()
            }
        case weekdayButtonCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisWeekdayButtonCollectionViewCell", for: indexPath) as? TardisWeekdayButtonCollectionViewCell {
                cell.bindData(weekDay: Weekday.getWeekday(index: indexPath.section))
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
            weekdayCollectionView.scrollToItem(at: IndexPath(row: indexPath.section,
                                                             section: indexPath.row),
                                               at: .centeredHorizontally,
                                               animated: true)
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
extension TardisActivitiesViewController:TardisAddNewActivityPopupDelegate {
    func addActivity(activity: TardisActivityObject) {
        dataModel.addActivity(activity: activity) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Thêm mới thành công")
                self.weekdayCollectionView.reloadData()
            } else {
                CommonFunction.annoucement(title: "", message: "Thêm mới thất bại")
            }
        }
    }
}

//Sample Data
extension TardisActivitiesViewController {
    func exampleData()  {
        //Sun
        let activity01 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:59", endTime: "07:00", note: "Ăn sáng", location: "Tue")
        let activity02 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity03 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity04 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity05 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity0 = [TardisActivityObject]()
        activity0.append(activity01)
        activity0.append(activity02)
        activity0.append(activity03)
        activity0.append(activity04)
        activity0.append(activity05)
        weekActivities.append(activity0)
        //Mon
        let activity11 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:00", endTime: "06:05", note: "Ăn sáng", location: "Tue")
        let activity12 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity13 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity14 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity15 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity1 = [TardisActivityObject]()
        activity1.append(activity11)
        activity1.append(activity12)
        activity1.append(activity13)
        activity1.append(activity14)
        activity1.append(activity15)
        weekActivities.append(activity1)
        //Tue
        let activity21 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:59", endTime: "07:00", note: "Ăn sáng", location: "Tue")
        let activity22 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity23 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity24 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity25 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity2 = [TardisActivityObject]()
        activity2.append(activity21)
        activity2.append(activity22)
        activity2.append(activity23)
        activity2.append(activity24)
        activity2.append(activity25)
        weekActivities.append(activity2)
        //Web
        let activity31 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:59", endTime: "07:00", note: "Ăn sáng", location: "Tue")
        let activity32 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity33 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity34 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity35 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity3 = [TardisActivityObject]()
        activity3.append(activity31)
        activity3.append(activity32)
        activity3.append(activity33)
        activity3.append(activity34)
        activity3.append(activity35)
        weekActivities.append(activity3)
        //Thus
        let activity41 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:59", endTime: "07:00", note: "Ăn sáng", location: "Tue")
        let activity42 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity43 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity44 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity45 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity4 = [TardisActivityObject]()
        activity4.append(activity41)
        activity4.append(activity42)
        activity4.append(activity43)
        activity4.append(activity44)
        activity4.append(activity45)
        weekActivities.append(activity4)
        //Fri
        let activity51 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:59", endTime: "07:00", note: "Ăn sáng", location: "Tue")
        let activity52 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity53 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity54 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity55 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity5 = [TardisActivityObject]()
        activity5.append(activity51)
        activity5.append(activity52)
        activity5.append(activity53)
        activity5.append(activity54)
        activity5.append(activity55)
        weekActivities.append(activity5)
        //Sat
        let activity61 = TardisActivityObject(activityName: "Ăn sáng", startTime: "06:59", endTime: "07:00", note: "Ăn sáng", location: "Tue")
        let activity62 = TardisActivityObject(activityName: "Đi học", startTime: "07:00", endTime: "07:30", note: "Ăn sáng", location: "")
        let activity63 = TardisActivityObject(activityName: "Nấu cơm", startTime: "08:30", endTime: "11:00", note: "Ăn sáng", location: "")
        let activity64 = TardisActivityObject(activityName: "Làm bếp", startTime: "11:30", endTime: "12:00", note: "Ăn sáng", location: "")
        let activity65 = TardisActivityObject(activityName: "Chơi game", startTime: "13:00", endTime: "18:00", note: "Ăn sáng", location: "")
        
        var activity6 = [TardisActivityObject]()
        activity6.append(activity61)
        activity6.append(activity62)
        activity6.append(activity63)
        activity6.append(activity64)
        activity6.append(activity65)
        weekActivities.append(activity6)
        dataModel.dailyActivityArray = weekActivities
    }
}
