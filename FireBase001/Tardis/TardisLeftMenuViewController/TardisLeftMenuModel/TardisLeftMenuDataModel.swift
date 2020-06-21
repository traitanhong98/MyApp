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
    var avatarImage: UIImage?
    override init() {
        super.init()
    }
    
    // MARK: - SetupData
    func getAvatar() {
        if UserInfo.getUID().count > 0 && UserInfo.currentUser.imageUrl.count > 0 {
            let url = URL(string: UserInfo.currentUser.imageUrl)
             CommonFunction.getData(from: url!, completion: { (data, res, err) in
                if err != nil {
                    return
                }
                DispatchQueue.main.async {
                    self.avatarImage = UIImage(data: data!)
                    self.selfView?.leftMenuCollectionView.reloadData()
                }
            })
        }
    }
    // MARK: - CollectionViewDelegate
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
                    if avatarImage != nil {
                        cell.avatarImgView.image = avatarImage
                    }
                    cell.bindData(user: UserInfo.currentUser)
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
                cell.bindData(setting: Setting.allLoggedInSetting[indexPath.row])
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
        return  CGSize(width: (selfView?.view.frame.width)!, height: 50)
    }
    
    func numberOfItemsInSection( collectionView: UICollectionView, section: Int) -> Int {
        if CommonFunction.isLogin() {
            return Setting.allLoggedInSetting.count
        } else {
            return Setting.allSetting.count
        }
    }
    
    func didSelectItemAt(_ collectionView: UICollectionView,  indexPath: IndexPath) {
        if CommonFunction.isLogin() {
            didSelectLoggedInCell(collectionView, indexPath: indexPath)
        } else {
            didSelectNotLogInCell(collectionView, indexPath: indexPath)
        }
    }
    
    func didSelectLoggedInCell(_ collectionView: UICollectionView,  indexPath: IndexPath) {
        switch indexPath.row {
        case Setting.userBlock.settingIndex:
            CommonFunction.rootVC.showUserInfo()
            break
        case Setting.commonSetting.settingIndex:
            break
        case Setting.appInfo.settingIndex:
            //Do something
            break
        case Setting.devInfo.settingIndex:
            //Do something
            break
        case Setting.logOut.settingIndex:
            CommonFunction.rootVC.doLogout()
            avatarImage = nil
            break
        default:
            break
        }
    }
    
    func didSelectNotLogInCell(_ collectionView: UICollectionView,  indexPath: IndexPath) {
        switch indexPath.row {
        case Setting.userBlock.settingIndex:
            CommonFunction.rootVC.showUserInfo()
            break
        case Setting.commonSetting.settingIndex:
            break
        case Setting.appInfo.settingIndex:
            //Do something
            break
        case Setting.devInfo.settingIndex:
            //Do something
            break
        default:
            break
        }
    }
}
