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
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var heightOfHeaderView: NSLayoutConstraint!
    //MARK:- Propeties
    var dataModel = TardisWeekDayCollectionViewCellDataModel()
    var weekDay: Weekday?
    var sizeRatio: Float = 1 {
        didSet{
            activityCollectionView.reloadData()
            timeCollectionView.reloadData()
            dataModel.sizeRatio = sizeRatio
        }
    }
    @IBOutlet weak var weekDayImageView: UIImageView!
    var viewMode = ViewMode.dayHour
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        
        registerCell()
        setupCollectionView()
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
        self.mainCellView.sendSubviewToBack(timeCollectionView)
    }
    
    func bindData(weekDay: Weekday, sizeRatio: Float, activities: [TardisActivity],viewMode: ViewMode) {
        self.sizeRatio = sizeRatio
        self.weekDay = weekDay
        dataModel.activities = activities
        dataModel.viewMode = viewMode
        self.viewMode = viewMode
        weekdayLabel.text = weekDay.rawValue
        activityCollectionView.reloadData()
        activityCollectionView.layoutIfNeeded()
    }
    
    func scrollToFirst() {
        if viewMode == .normal {
            return
        }
        if CommonFunction.getCurrentDayOfWeek() == self.weekDay?.rawValue {
            for section in 0...(dataModel.activities.count - 1) {
                if dataModel.activities[section].startTime > CommonFunction.getCurrenFloatTime() {
                    activityCollectionView.scrollToItem(at: IndexPath(row: 0, section: section),
                                                        at: .top,
                                                        animated: true)
                    break
                } else {
                    activityCollectionView.scrollToItem(at: IndexPath(row: 0, section: dataModel.activities.count),
                    at: .top,
                    animated: true)
                }
            }
        } else {
            var startFloatTime = CommonFunction.timeToFloat(time: dataModel.activities[0].startTime)
            startFloatTime -= Float(activityCollectionView.frame.size.width * 1.5)
            activityCollectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
        }
    }
    func calculatingHeightOfItem(startTime: String,endTime: String) -> Float{
        let start = CommonFunction.timeToFloat(time: startTime)
        let end = CommonFunction.timeToFloat(time: endTime)
        let heightResult = (end - start) * 60
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
// MARK: - UICollectionViewDelegate
extension TardisWeekdayCollectionViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case activityCollectionView:
            return dataModel.activities.count + 1
        case timeCollectionView:
            return 24
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case activityCollectionView:
            if section == 0 {
                return 0
            } else {
                return 1
            }
        case timeCollectionView:
            return 1
        default:
            return 1
        }
    }
    //CellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case activityCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisActivityCollectionViewCell", for: indexPath) as? TardisActivityCollectionViewCell {
                cell.bindData(data: dataModel.activities[indexPath.section - 1],sizeRatio: sizeRatio)
                return cell
            } else {
                return UICollectionViewCell()
            }
        case timeCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisHourCollectionViewCell", for: indexPath) as? TardisHourCollectionViewCell {
                cell.bindData(hour: indexPath.section + 1,sizeRatio: sizeRatio)
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
            return dataModel.activityCollectionView(collectionView, referenceSizeForFooterInSection: section)
        case timeCollectionView:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TardisWeekdayCollectionViewCell:UICollectionViewDelegateFlowLayout {
    //SizeForItem
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case activityCollectionView:
            let width = Float(activityCollectionView.frame.size.width - 10)
            if indexPath.section == 0 {
                return CGSize(width: CGFloat(width), height: 0)
            }
            var height:Float = 0
            if viewMode == .dayHour {
                height = calculatingHeightOfItem(startTime: dataModel.activities[indexPath.section - 1].startTime, endTime: dataModel.activities[indexPath.section - 1].endTime)
            } else {
                height = 100
            }
            return CommonFunction.getSizeWithRatio(width: width,
                                                   height: height,
                                                   ratio: sizeRatio)
        case timeCollectionView:
            let width = Float(timeCollectionView.frame.size.width)
            if viewMode == .dayHour {
                return CommonFunction.getSizeWithRatio(width: width,
                                                       height: 60,
                                                       ratio: sizeRatio)
            } else {
                return CommonFunction.getSizeWithRatio(width: width,
                height: 0,
                ratio: sizeRatio)
            }
            
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
