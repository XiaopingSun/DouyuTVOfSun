//
//  RecommendViewModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/7.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

// 发送网络请求
extension RecommendViewModel {
    
    func requestData(finishCallback: @escaping () -> ()) {
        
        let parameters = ["limit" : "4", "offset":"0", "time":NSDate.getCurrentTime() as NSString]
        
        let requestGroup = DispatchGroup()
        
        requestGroup.enter()
        NetworkTool.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime() as NSString]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            requestGroup.leave()
        }
        
        requestGroup.enter()
        NetworkTool.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            requestGroup.leave()
        }
        
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1536311370
        requestGroup.enter()
        NetworkTool.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            requestGroup.leave()
        }
        
        requestGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }))
    }
}
