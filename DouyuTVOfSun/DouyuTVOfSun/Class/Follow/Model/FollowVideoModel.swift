//
//  FollowVideoModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/24.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class FollowVideoModel: NSObject {
    @objc var title: String = ""
    @objc var thumbImageUrl: String = ""
    @objc var url: String = ""
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
