//
//  PageContentView.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/3.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

private let cellIdentifier: String = "cellIdentifier"

class PageContentView: UIView {
    
    private var childViewControllers: [UIViewController]
    
    private var parentViewController: UIViewController
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        return collectionView
    }()

    init(frame: CGRect, childViewControllers: [UIViewController], parentViewController: UIViewController) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    
    private func setupUI() {
        for childViewController in childViewControllers {
            parentViewController.addChildViewController(childViewController)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childViewControllers[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}





