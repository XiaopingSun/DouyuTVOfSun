//
//  RecommendGameView.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/10.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin: CGFloat = 10.0

class RecommendGameView: UIView {
    
    var groups: [AnchorGroup]? {
        didSet {
            // 移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionVIew.reloadData()
        }
    }
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .flexibleWidth
        collectionVIew.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionVIew.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVIew.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        return cell
    }
}
