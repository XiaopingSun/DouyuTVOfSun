//
//  AnchorGroupModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/7.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    // 该组中对应的房间信息
    @objc var room_list: [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 组显示的图标
    @objc var icon_name: String = "home_header_normal"
    
    // 主播模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
}
