//
//  NormalCollectionViewCell.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/5.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet var roomNameLabel: UILabel!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
