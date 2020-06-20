//
//  TardisLeftMenuViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/12/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisLeftMenuViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var leftMenuCollectionView: UICollectionView!
    
    // MARK: - Var
    let dataModel = TardisLeftMenuDataModel()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.selfView = self
        dataModel.setupLeftMenuCollectionView(collectionView: leftMenuCollectionView)
    }
    override func viewWillAppear(_ animated: Bool) {
        if dataModel.avatarImage == nil {
            dataModel.getAvatar()
        }
        leftMenuCollectionView.reloadData()
    }
    // MARK: - Func
    // MARK: - IBActions
    

}

// MARK: - CollectionViewDataSource
extension TardisLeftMenuViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Setting.allSetting.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataModel.cellForMenu(collectionView: collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataModel.sizeForMenuCollectionView(sizeForItemAt: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case Setting.userBlock.settingIndex:
            if UserInfo.userDidLogin() {
                CommonFunction.rootVC.showUserInfo()
                break
            }
        default:
            print("err")
        }
    }
}

// MARK: - TardisNotLoginMenuCollectionViewCellDelegate
extension TardisLeftMenuViewController: TardisNotLoginMenuCollectionViewCellDelegate {
    func loginAction() {
        CommonFunction.rootVC.hideLeftView(animated: true) {
            CommonFunction.rootVC.openLogin()
        }
    }
}
