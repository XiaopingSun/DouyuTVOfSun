//
//  UIColor-Extension.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/3.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
