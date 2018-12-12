//
//  CollectionGameCell.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/10.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var baseGame: BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            let url = NSURL(string: baseGame?.icon_url ?? "")!
            iconImage.kf.setImage(with: ImageResource(downloadURL: url as URL), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
