//
//  ChatModel.swift
//  Joke
//
//  Created by 谭安溪 on 2016/11/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class ChatModel: NSObject {
    ///聊天内容
    var content: String = ""
    
    ///头像
    var icon: String = ""
    
    ///角色
    var role : String = "" {
        didSet {
            if role == "MINE" {
                isMe = true
            }else{
                isMe = false
            }
        }
    }
    
    var isMe : Bool = false
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
