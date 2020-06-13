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

    }
    
    // MARK: - Func
    func setupData() {
        
    }
    
    func setupCollectionView() {
        leftMenuCollectionView.register(UINib(nibName: "TardisCommonMenuCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "TardisCommonMenuCollectionViewCell")
        leftMenuCollectionView.register(UINib(nibName: "TardisLogedInMenuCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "TardisLogedInMenuCollectionViewCell")
        leftMenuCollectionView.register(UINib(nibName: "TardisNotLoginMenuCollectionViewCell",
                                              bundle: nil),
                                        forCellWithReuseIdentifier: "TardisNotLoginMenuCollectionViewCell")
        leftMenuCollectionView.delegate = self
        leftMenuCollectionView.dataSource = self
    }
    // MARK: - IBActions
    

}

// MARK: - CollectionViewDataSource
extension TardisLeftMenuViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Setting.allSetting.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case Setting.userBlock.settingIndex:
            <#code#>
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
