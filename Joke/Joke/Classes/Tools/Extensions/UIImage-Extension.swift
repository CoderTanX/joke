//
//  UIImage-Extension.swift
//  图片圆角
//
//  Created by 谭安溪 on 2016/11/10.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

extension UIImage{
    func circleImage() -> UIImage{
        
        //开始图片上下文
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        //获取上下文
        let context =  UIGraphicsGetCurrentContext()!
        //画圆
        context.addEllipse(in: rect)
        //裁剪
        context.clip()
        
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //结束上下文
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
