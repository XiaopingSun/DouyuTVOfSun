//
//  MainViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/8/28.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }
    
    private func addChildVC(storyName: String) {
        // 1.通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVC作为子控制器
        addChildViewController(childVC)
    }
}
