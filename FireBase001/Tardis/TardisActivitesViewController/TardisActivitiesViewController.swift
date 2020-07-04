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
    var viewMode = ViewMode.normal {
        didSet{
            weekdayCollectionView.reloadData()
        }
    }
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeData()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        registerCell()
    }
    deinit {
        dataModel.reset()
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
    func observeData() {
        dataModel.observeActivities { (status) in
            if status {
                self.weekdayCollectionView.reloadData()
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
extension TardisActivitiesViewController: TardisWeekdayCollectionViewCellDelegate {
    func editActivity(activity: TardisActivityObject) {
        dataModel.addActivity(activity: activity) { (status) in
            if status {
                CommonFunction.annoucement(title: "", message: "Cập nhật thành công")
                self.weekdayCollectionView.reloadData()
            } else {
                CommonFunction.annoucement(title: "", message: "Cập nhật thất bại")
            }
        }
    }
}
