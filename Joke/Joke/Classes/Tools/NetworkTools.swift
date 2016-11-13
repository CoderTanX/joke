//
//  NetworkTools.swift
//  Joke
//
//  Created by 董宏 on 16/11/13.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get
    case post
}
class NetworkTools {
    
    /// 网络请求
    ///
    /// - parameter type:             请求类型
    /// - parameter url:              请求地址
    /// - parameter parameters:       请求参数
    /// - parameter finishedCallBack: 请求完成回调
    static func requestData(_ type: MethodType, url: String, parameters:[String: Any]? = nil, finishedCallBack:@escaping (_ result: [String: Any]) -> ()){
        //判断请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        //发送请求
        _ = Alamofire.request(url, method: method, parameters: parameters).responseJSON(completionHandler: { (response) in
            //判断返回数据
            guard let result = response.result.value as? [String: Any] else{
                print(response.result.error)
                return
            }
            //判断状态码
            guard result["code"] as! Int == 1 else{
                print(result["message"] as! String)
                return
            }
            //执行回调
            finishedCallBack(result)
            
        })
    }
}
