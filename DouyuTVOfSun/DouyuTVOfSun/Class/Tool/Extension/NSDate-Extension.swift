//
//  NSDate-Extension.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/7.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowData = NSDate()
        let interval = Int(nowData.timeIntervalSince1970)
        return "\(interval)"
    }
}
