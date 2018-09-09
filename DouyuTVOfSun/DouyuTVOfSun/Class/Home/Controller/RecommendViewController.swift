//
//  RecommendViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/4.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10.0
private let kItemWidth = (kScreenWidth - 3 * kItemMargin) / 2.0
private let kNormalItemHeight = kItemWidth * 3 / 4
private let kPrettyItemHeight = kItemWidth * 4 / 3

private let kNormalCellID: String = "normal_cell _id"
private let kPrettyCellID: String = "pretty_cell _id"
private let kHeaderID: String = "header_id"
private let kHeaderHeight: CGFloat = 50

class RecommendViewController: UIViewController {
    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()

    private lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "HomeCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}

// 设置UI
extension RecommendViewController {
    private func setupUI() {
        self.view.addSubview(collectionView)
    }
}

// 请求数据
extension RecommendViewController {
    private func loadData() {
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
    }
}

// UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        
        var cell: BaseCollectionViewCell
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCollectionViewCell

        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        }
        cell.anchor = anchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HomeCollectionReusableView
        headerView.anchorGroup = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        }
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }
}

