//
//  PrettyCollectionViewCell.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/5.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet var cityButton: UIButton!
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
