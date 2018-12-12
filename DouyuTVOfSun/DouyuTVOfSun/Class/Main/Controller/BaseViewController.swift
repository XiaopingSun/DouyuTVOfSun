//
//  BaseViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView: UIView?
    
    private lazy var animationImageView: UIImageView = {[weak self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
}

extension BaseViewController {
    @objc func setupUI() {
        contentView?.isHidden = true
        view.addSubview(animationImageView)
        animationImageView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    @objc func loadData() {
        
    }
    @objc func loadDataFinished() {
        animationImageView.stopAnimating()
        animationImageView.isHidden = true
        contentView?.isHidden = false
    }
}
