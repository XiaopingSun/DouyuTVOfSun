//
//  BaseAnchorViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10.0
private let kItemWidth = (kScreenWidth - 3 * kItemMargin) / 2.0
private let kNormalItemHeight = kItemWidth * 3 / 4
private let kPrettyItemHeight = kItemWidth * 4 / 3
private let kHeaderHeight: CGFloat = 50

private let kNormalCellID: String = "normal_cell _id"
private let kPrettyCellID: String = "pretty_cell _id"
private let kHeaderID: String = "header_id"

class BaseAnchorViewController: BaseViewController {
    
    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = {[unowned self] in
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
}

extension BaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }
}

extension BaseAnchorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM?.anchorGroups.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM?.anchorGroups[section].anchors.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        cell.anchor = baseVM!.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! HomeCollectionReusableView
        headerView.anchorGroup = baseVM!.anchorGroups[indexPath.section]
        return headerView
    }
}

extension BaseAnchorViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//        anchor.isVertical == 1 ? presentShowRoomVC() : pushNormalRoomVC()
//    }
//
//    private func presentShowRoomVC() {
//        let showRoomVC = RoomShowViewController()
//        present(showRoomVC, animated: true, completion: nil)
//    }
//
//    private func pushNormalRoomVC() {
//        let normalRoomVC = RoomPlayerViewController()
//        navigationController?.pushViewController(normalRoomVC, animated: true)
//    }
}
