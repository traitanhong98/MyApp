//
//  TardisChannelCheckListViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChannelCheckListViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var checkListCollectionView: UICollectionView!
    var page: TardisChannelPage!
    var currentChannel: TardisChannelObject!
    var checkList = [TardisChannelChecklistObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        // Do any additional setup after loading the view.
    }
    func registerCollectionView() {
        checkListCollectionView.register(UINib(nibName: "TardisCheckListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TardisCheckListCollectionViewCell")
        checkListCollectionView.delegate = self
        checkListCollectionView.dataSource = self
    }
    @IBAction func addCheckListAction(_ sender: Any) {
        let popupChecklist = AddCheckListPopup()
        popupChecklist.show()
    }

}
extension TardisChannelCheckListViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = checkListCollectionView.dequeueReusableCell(withReuseIdentifier: "TardisCheckListCollectionViewCell", for: indexPath) as? TardisCheckListCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width * 0.9,
                     height: self.view.frame.height * 0.9)
    }
}
