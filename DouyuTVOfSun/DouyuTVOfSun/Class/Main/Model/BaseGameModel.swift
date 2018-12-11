//
//  BaseGameModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/11.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    @objc var tag_name: String = ""
    @objc var icon_url: String = ""
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    override init() {}
}
