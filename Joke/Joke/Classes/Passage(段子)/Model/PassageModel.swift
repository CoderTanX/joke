//
//  PassageModel.swift
//  Joke
//
//  Created by 董宏 on 16/11/13.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class PassageModel: NSObject {
    
    /// 笑话
    var content: String = ""
    
    /// 时间
    var time: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
