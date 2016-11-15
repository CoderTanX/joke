//
//  GodReplyViewModel.swift
//  Joke
//
//  Created by 谭安溪 on 2016/11/15.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class GodReplyViewModel: NSObject {
    var chatsGroup: [[ChatModel]] = [[ChatModel]]()
}
extension GodReplyViewModel {
    func loadChatData(_ page:Int = 1, pageSize:Int = 10, finishedCallBack: @escaping () -> ()){
        NetworkTools.requestData(.get, url: "https://bogaara.duapp.com/chats.php", parameters: ["page": page, "pageSize": pageSize]) { (result) in
            //            print(result["data"] as! [[String: Any]])
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            for dict in dataArray{
                let content = dict["content"] as! String
                let chats = content.components(separatedBy: "#")
                var chatsArray = [ChatModel]()
                for (index,chat) in chats.enumerated() {
                    let dict: [String : Any] = ["content": chat, "role": index%2]
                    chatsArray.append(ChatModel(dict: dict))
                }
                self.chatsGroup.append(chatsArray)
            }
            finishedCallBack()
        }
    }

}
