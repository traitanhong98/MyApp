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
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        registerCell()
        setupView()
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
        centeredWeekdayCollectionView.itemSize = CGSize(
            width: weekdayCollectionView.frame.width - 80,
            height: weekdayCollectionView.frame.height - 2
        )
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
                cell.bindData(weekDay: Weekday.getWeekday(index: indexPath.row))
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is TardisWeekdayCollectionViewCell {
//            weekdayCell.scrollToFirst()
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

