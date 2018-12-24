//
//  FollowPlayerCell.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/21.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

private let kIconImageWidth: CGFloat = 40

class FollowPlayerCell: UITableViewCell {
    
    var videoModel: FollowVideoModel? {
        didSet {
            guard let videoModel = videoModel else {return}
            titleLabel.text =  videoModel.title
            iconImageV.image = UIImage(named: "videoIcon")
            let url = NSURL(string: videoModel.thumbImageUrl)!
            thumbImageV.kf.setImage(with: ImageResource(downloadURL: url as URL), placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    private lazy var thumbImageV: UIImageView = {
        let thumbImageV = UIImageView(frame: CGRect.zero)
        thumbImageV.layer.masksToBounds = true
        thumbImageV.layer.cornerRadius = 10
        thumbImageV.contentMode = .scaleAspectFit
        thumbImageV.backgroundColor = UIColor.black
        addSubview(thumbImageV)
        return thumbImageV
    }()
    
    private lazy var iconImageV: UIImageView = {
        let iconImageV = UIImageView(frame: CGRect.zero)
        iconImageV.layer.masksToBounds = true
        iconImageV.layer.cornerRadius = kIconImageWidth / 2
        thumbImageV.addSubview(iconImageV)
        return iconImageV
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        titleLabel.textColor = UIColor.white
        thumbImageV.addSubview(titleLabel)
        return titleLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension FollowPlayerCell {
    private func setupUI() {
        thumbImageV.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo((kScreenWidth - 20) / 16 * 9)
        }
        iconImageV.snp.makeConstraints { (make) in
            make.left.equalTo(thumbImageV).offset(10)
            make.bottom.equalTo(thumbImageV).offset(-10)
            make.width.height.equalTo(kIconImageWidth)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageV.snp.right).offset(10)
            make.bottom.equalTo(iconImageV)
            make.height.equalTo(20)
        }
    }
}

extension FollowPlayerCell {
    class func height() -> CGFloat {
        return (kScreenWidth - 20) / 16 * 9 + 10
    }
}
