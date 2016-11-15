//
//  GodReplyViewController.swift
//  Joke
//
//  Created by 谭安溪 on 2016/11/14.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import iCarousel
class GodReplyViewController: UIViewController {
    
    fileprivate lazy var godReplyMV: GodReplyViewModel = GodReplyViewModel()
    
    @IBOutlet weak var carousel: iCarousel!
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.scrollSpeed = 0.7
        automaticallyAdjustsScrollViewInsets = false
        loadData()
    }

}

//MARK: - 请求数据
extension GodReplyViewController {
    fileprivate func loadData(){
        godReplyMV.loadChatData { 
            self.carousel.reloadData()
        }
    }
}

//MARK:- iCarousel数据源&代理
extension GodReplyViewController: iCarouselDataSource,iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return godReplyMV.chatsGroup.count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView{
        var itemView: ChatTableView
        if let view = view as? ChatTableView {
            itemView = view
        }else{
            //聊天视图
            itemView = ChatTableView(frame: CGRect(x: 0, y: 0, width: kScreenW * 0.95, height: kScreenH - kNavigationBarH - kStatusBarH - kTabBarH - 40), style: .plain)
            itemView.layer.cornerRadius = 5
            itemView.layer.masksToBounds = true
        }
        itemView.chatModels = godReplyMV.chatsGroup[index]
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
}
