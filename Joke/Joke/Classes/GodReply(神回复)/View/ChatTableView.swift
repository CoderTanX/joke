//
//  ChatTableView.swift
//  Joke
//
//  Created by 谭安溪 on 2016/11/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class ChatTableView: UITableView {
    
    var chatModels: [ChatModel]? {
        didSet{
            reloadData()
        }
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self

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
        return chatModels?.count ?? 0
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatViewCell.cell(tableView: tableView)
        cell.chatModel = chatModels![indexPath.row]
        return cell
    }
}
