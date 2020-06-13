//
//  TardisLeftMenuDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/13/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisLeftMenuDataModel: NSObject {
    var selfView: TardisLeftMenuViewController?
    // MARK: - CollectionView
    func setupLeftMenuCollectionView(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "TardisCommonMenuCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "TardisCommonMenuCollectionViewCell")
        collectionView.register(UINib(nibName: "TardisLogedInMenuCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "TardisLogedInMenuCollectionViewCell")
        collectionView.register(UINib(nibName: "TardisNotLoginMenuCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "TardisNotLoginMenuCollectionViewCell")
        collectionView.delegate = selfView
        collectionView.dataSource = selfView
    }
    func cellForMenu(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case Setting.userBlock.settingIndex:
            if CommonFunction.isLogin() {
                if let cell = collectionView.dequeueReusableCell(
                                    withReuseIdentifier: "TardisLogedInMenuCollectionViewCell",
                                    for: indexPath)
                                        as? TardisLogedInMenuCollectionViewCell {
                    return cell
                } else {
                    return UICollectionViewCell()
                }
            } else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TardisNotLoginMenuCollectionViewCell", for: indexPath) as? TardisNotLoginMenuCollectionViewCell {
                    cell.delegate = selfView
                    return cell
                } else {
                    return UICollectionViewCell()
                }
            }
            
        default:
            if let cell = collectionView.dequeueReusableCell(
                                withReuseIdentifier: "TardisCommonMenuCollectionViewCell",
                                for: indexPath)
                as? TardisCommonMenuCollectionViewCell {
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        
    }
    
    func sizeForMenuCollectionView(sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == Setting.userBlock.settingIndex {
            return CGSize(width: (selfView?.view.frame.width)!, height: 100)
        }
        return  CGSize(width: (selfView?.view.frame.width)!, height: 40)
    }
}
