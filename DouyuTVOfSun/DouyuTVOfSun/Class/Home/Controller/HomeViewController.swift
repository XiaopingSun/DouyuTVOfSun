//
//  HomeViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/8/29.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenWidth, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = {
        let contentH = kScreenHeight - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenWidth, height: contentH)
        
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor(r: CGFloat(arc4random() % 255), g: CGFloat(arc4random() % 255), b: CGFloat(arc4random() % 255))
            childVCs.append(viewController)
        }
        let pageContentView = PageContentView(frame: contentFrame, childViewControllers: childVCs, parentViewController: self)
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        setupUI() 
    }
}

// 设置UI
extension HomeViewController {
    
    private func setupUI() {
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加titleView
         view.addSubview(pageTitleView)
        
        // 3.添加contentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        // 1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧的item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", selectedImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", selectedImageName: "btn_search_click", size: size)
        let QRCodeItem = UIBarButtonItem(imageName: "Image_scan", selectedImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem, searchItem, QRCodeItem]
    }
}
