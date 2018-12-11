//
//  GameViewModel.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/11.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games: [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        NetworkTool.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            guard let resultDict = result as? [String: Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            finishedCallback()
        }
    }
}
