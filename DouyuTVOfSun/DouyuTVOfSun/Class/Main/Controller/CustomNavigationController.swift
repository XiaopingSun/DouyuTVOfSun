//
//  CustomNavigationController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGesture = interactivePopGestureRecognizer else {return}
        guard let gestureView = systemGesture.view else {return}
        
//        var count: UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
        
        let targets = systemGesture.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        
        guard let target = targetObjc.value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        let panGesture = UIPanGestureRecognizer()
        gestureView.addGestureRecognizer(panGesture)
        panGesture.addTarget(target, action: action)
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
}
