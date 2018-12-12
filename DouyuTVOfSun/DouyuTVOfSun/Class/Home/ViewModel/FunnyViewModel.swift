//
//  FunnyViewModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData:false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/1", parameters: ["limit": 30, "offset": 0], finishedCallback: finishedCallback)
    }
}
