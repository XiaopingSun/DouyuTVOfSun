//
//  HomeCollectionReusableView.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/4.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    var anchorGroup: AnchorGroup? {
        didSet {
            titleLabel.text = anchorGroup?.tag_name
            iconImageView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
