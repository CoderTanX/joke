//
//  PassageViewMoel.swift
//  Joke
//
//  Created by 董宏 on 16/11/13.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class PassageViewMoel {
    var passageModels: [PassageModel] = [PassageModel]()
}
//MARK:- 请求数据
extension PassageViewMoel {
    func loadPassageData(_ page:Int = 1, pageSize:Int = 10, finishedCallBack: @escaping () -> ()){
        NetworkTools.requestData(.get, url: "https://bogaara.duapp.com/list.php", parameters: ["page": page, "pageSize": pageSize]) { (result) in
//            print(result["data"] as! [[String: Any]])
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            for dic in dataArray{
                self.passageModels.append(PassageModel(dict: dic))
            }
            finishedCallBack()
        }
    }
}
