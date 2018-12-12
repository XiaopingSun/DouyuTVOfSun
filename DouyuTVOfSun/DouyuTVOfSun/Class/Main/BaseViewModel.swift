//
//  BaseViewModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping () -> ()) {
        NetworkTool.requestData(type: .GET, URLString: URLString, parameters: parameters) { (result) in
            guard let resultDict = result as? [String: Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict:dict))
                }
            } else {
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }

            finishedCallback()
        }
    }
}
