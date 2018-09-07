//
//  RecommendViewModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/7.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

class RecommendViewModel {
    private lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

// 发送网络请求
extension RecommendViewModel {
    
    func requestData() {
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1536311370
        print(NSDate.getCurrentTime())
        NetworkTool.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4", "offset":"0", "time":NSDate.getCurrentTime() as NSString]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for anchorGroup in self.anchorGroups {
                for anchor in anchorGroup.anchors {
                    print(anchor.nickname)
                }
            }
        }
    }
}
