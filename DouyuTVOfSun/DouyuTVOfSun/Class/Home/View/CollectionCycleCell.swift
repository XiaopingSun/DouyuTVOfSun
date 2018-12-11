//
//  CollectionCycleCell.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/10.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // 定义模型属性
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL), placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
