//
//  ChatTableView.swift
//  Joke
//
//  Created by 谭安溪 on 2016/11/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class ChatTableView: UITableView {
    
    fileprivate var chatModels: [ChatModel] = [ChatModel]()
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        let dataArray = [["content" : "你好" , "icon" : "katong","role" : "SOMEONE"] ,
                         ["content" : "好" , "icon" : "mm","role" : "MINE"] ,
                         ["content" : "你好" , "icon" : "katong","role" : "SOMEONE"] ,
                         ["content" : "精品 - 纯代码 swift 聊天 微信 qq UITableView Chat<夜黑执事 出品>" , "icon" : "katong","role" : "SOMEONE"] ,
                         ["content" : "你好" , "icon" : "mm","role" : "MINE"] ,
                         ["content" : "精品 - 纯代码 swift 聊天 微信 qq UITableView Chat<夜黑执事 出品>" , "icon" : "katong","role" : "SOMEONE"] ,
                         ["content" : "我都不知道自己在干什么" , "icon" : "katong","role" : "SOMEONE"]]
        
        for dic in dataArray {
            chatModels.append(ChatModel(dict: dic))
        }
        estimatedRowHeight = 50
        rowHeight = UITableViewAutomaticDimension
        separatorStyle = .none
        backgroundColor = UIColor(r: 235, g: 235, b: 235)
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatTableView: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatModels.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatViewCell.cell(tableView: tableView)
        cell.chatModel = chatModels[indexPath.row]
        return cell
    }
}
