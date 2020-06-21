//
//  TardisActivityCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/24/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisActivityCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var containerView: TardisView!
    @IBOutlet weak var headerView: TardisView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var markIconStackView: UIStackView!
    //MARK: - Propeties
    var sizeRatio:Float = 1 {
        didSet{
            self.titleLabel.font = titleLabel.font.withSize(CGFloat(14 * sizeRatio))
            self.descriptionLabel.font = descriptionLabel.font.withSize(CGFloat(14 * sizeRatio))
        }
    }
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - Func
    func bindData(data: TardisActivityObject,sizeRatio: Float) {
        self.titleLabel.text = "\(data.activityName) \(data.startTime)-\(data.endTime)"
        self.descriptionLabel.text = "\(data.note)"
    }
    
    func setupUI() {
        markIconStackView.spacing = 2
        markIconStackView.alignment = .center
        markIconStackView.addArrangedSubview(createMarkIcon(imgName: "alarm"))
    }
    
    func createMarkIcon(imgName: String) -> UIImageView{
        let markIcon = UIImageView()
        markIcon.frame.size = CGSize(width: markIconStackView.frame.height,
                                     height: markIconStackView.frame.height)
        markIcon.image = UIImage(named: imgName)
        markIcon.contentMode = .scaleAspectFit
        return markIcon
    }
    
}
