//
//  BaseCollectionViewCell.swift
//  DouyuTVOfSun
//
//  Created by SunXP on 2018/9/9.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var onlineButton: UIButton!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor.nickname
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL, cacheKey: nil))
        }
    }
}
