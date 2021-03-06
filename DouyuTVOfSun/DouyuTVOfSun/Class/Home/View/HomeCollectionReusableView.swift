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
    @IBOutlet weak var moreButton: UIButton!
    
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

extension HomeCollectionReusableView {
    class func collectionHeaderView() -> HomeCollectionReusableView {
        return Bundle.main.loadNibNamed("HomeCollectionReusableView", owner: nil, options: nil)?.first as! HomeCollectionReusableView
    }
}
