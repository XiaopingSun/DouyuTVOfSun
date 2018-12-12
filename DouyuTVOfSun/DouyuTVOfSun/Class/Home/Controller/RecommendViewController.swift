//
//  RecommendViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/4.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenWidth * 3 / 8
private let kGameViewH: CGFloat = 90.0

private let kItemMargin: CGFloat = 10.0
private let kItemWidth = (kScreenWidth - 3 * kItemMargin) / 2.0
private let kNormalItemHeight = kItemWidth * 3 / 4
private let kPrettyItemHeight = kItemWidth * 4 / 3

private let kNormalCellID: String = "normal_cell _id"
private let kPrettyCellID: String = "pretty_cell _id"

class RecommendViewController: BaseAnchorViewController {
    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleCiew()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenWidth, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()
}

// 设置UI
extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        self.view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// 请求数据
extension RecommendViewController {
    override func loadData() {
        baseVM = recommendVM
        // 请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            var groups = self.recommendVM.anchorGroups
            
            // 移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            self.loadDataFinished()
        }
        //请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController:UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCollectionViewCell
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        } else {
            return CGSize(width: kItemWidth, height: kNormalItemHeight)
        }
    }
}
