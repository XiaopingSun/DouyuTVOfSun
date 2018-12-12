//
//  NetworkTool.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/9/5.
//  Copyright © 2018年 WorkSpace_Sun. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTool {
    class func requestData(type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result: AnyObject) -> ()) {
        let methodType = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: methodType, parameters: parameters).responseJSON { (resp) in
            guard let result = resp.result.value else {
                print(resp.error!)
                return
            }
            finishedCallback(result as AnyObject)
        }
    }
}
