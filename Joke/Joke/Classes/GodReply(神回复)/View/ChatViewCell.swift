//
//  ChatViewCell.swift
//  Joke
//
//  Created by 谭安溪 on 2016/11/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit


private let chatViewCellID: String = "chatViewCellID"

class ChatViewCell: UITableViewCell {
    
    var chatModel: ChatModel?{
        didSet{
            guard let chatModel = chatModel else { return }
            contentLabel.removeFromSuperview()
            bubbleImgView.removeFromSuperview()
            headerImgView.removeFromSuperview()
            
            
            //添加视图
            contentView.addSubview(headerImgView)
            contentView.addSubview(bubbleImgView)
            bubbleImgView.addSubview(contentLabel)
            //绑定数据
            headerImgView.image = UIImage(named: chatModel.icon)?.circleImage()
            bubbleImgView.image = chatModel.isMe ? UIImage(named: "chatfrom_bg_normal") : UIImage(named: "chatto_bg_normal")
            contentLabel.text = chatModel.content
            contentLabel.textAlignment = chatModel.isMe ? .left : .right
            
            //设置约束
            let views: [String: Any] = ["headerImgView": headerImgView, "content": contentLabel, "bubble": bubbleImgView]
            
            let header_constraint_H_Format  = chatModel.isMe ? "|-5-[headerImgView(50)]" : "[headerImgView(50)]-5-|"
            let header_constraint_V_Format  = chatModel.isMe ? "V:|-5-[headerImgView(50)]" : "V:|-5-[headerImgView(50)]"
            let bubble_constraint_H_Format  = chatModel.isMe ? "[headerImgView]-10-[bubble]-(>=50)-|" : "|-(>=50)-[bubble]-10-[headerImgView]"
            let bubble_constraint_V_Format  = chatModel.isMe ? "V:|-5-[bubble(>=50)]-5-|" : "V:|-5-[bubble(>=50)]-5-|"
            let content_constraint_H_Format = chatModel.isMe ? "|-18-[content]-10-|" : "|-10-[content]-18-|"
            let content_constraint_V_Format = chatModel.isMe ? "V:|-10-[content]-14-|" : "V:|-10-[content]-14-|"
            
            
            let header_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: header_constraint_H_Format, options: [], metrics: nil, views: views)
            let header_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: header_constraint_V_Format, options: [], metrics: nil, views: views)
            
            let bubble_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: bubble_constraint_H_Format, options: [], metrics: nil, views: views)
            let bubble_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: bubble_constraint_V_Format, options: [], metrics: nil, views: views)
            
            let content_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: content_constraint_H_Format, options: [], metrics: nil, views: views)
            let content_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: content_constraint_V_Format, options: [], metrics: nil, views: views)
            
            self.contentView.addConstraints(header_constraint_H)
            self.contentView.addConstraints(header_constraint_V)
            self.contentView.addConstraints(bubble_constraint_H)
            self.contentView.addConstraints(bubble_constraint_V)
            self.contentView.addConstraints(content_constraint_H)
            self.contentView.addConstraints(content_constraint_V)
            
        }
    }
    
    
    /// 聊天信息的label
    fileprivate lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        return contentLabel
    }()
    
    /// 头像
    fileprivate lazy var headerImgView: UIImageView = {
        let headerImgView = UIImageView()
        headerImgView.translatesAutoresizingMaskIntoConstraints = false
        return headerImgView
    }()
    
    /// 气泡
    fileprivate lazy var bubbleImgView: UIImageView = {
        let bubbleImgView = UIImageView()
        bubbleImgView.translatesAutoresizingMaskIntoConstraints = false
        return bubbleImgView
    }()
    
    static func cell(tableView: UITableView) -> ChatViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: chatViewCellID)
        if cell == nil {
            cell = ChatViewCell(style: .default, reuseIdentifier: chatViewCellID)
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.clear
        }
        return cell as! ChatViewCell
    }
    
    
}
