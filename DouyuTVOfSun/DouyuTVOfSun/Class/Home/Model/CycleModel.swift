//
//  CycleModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/10.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    @objc var title: String = ""
    // 图片
    @objc var pic_url: String = ""
    // 主播信息字典
    @objc var room: [String: NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息模型
    @objc var anchor: AnchorModel?
    
    // 自定义构造函数
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
