//
//  PassageViewController.swift
//  Joke
//
//  Created by 董宏 on 16/11/13.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import iCarousel
import PKHUD
class PassageViewController: UIViewController {
    fileprivate lazy var colorses: [[CGColor]] = {
        
        let colors1 = [UIColor(r: 180, g: 236, b: 81).cgColor, UIColor(r: 66, g: 147, b: 33).cgColor]
        let colors2 = [UIColor(r: 250, g: 217, b: 97).cgColor, UIColor(r: 247, g: 107, b: 28).cgColor]
        let colors3 = [UIColor(r: 229, g: 114, b: 233).cgColor, UIColor(r: 140, g: 39, b: 148).cgColor]
        let colors4 = [UIColor(r: 8, g: 161, b: 230).cgColor, UIColor(r: 33, g: 88, b: 139).cgColor]
        let colors5 = [UIColor(r: 240, g: 103, b: 115).cgColor, UIColor(r: 228, g: 57, b: 72).cgColor]
        let colors6 = [UIColor(r: 239, g: 241, b: 133).cgColor, UIColor(r: 207, g: 208, b: 48).cgColor]
        let colorses = [[CGColor]](arrayLiteral: colors1, colors2, colors3, colors4, colors5, colors6)
        return colorses;
    }()
    fileprivate var gradient:CAGradientLayer = CAGradientLayer()
    fileprivate let passageVM: PassageViewMoel = PassageViewMoel()
    fileprivate var currentPage: Int = 1
    @IBOutlet weak var carousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

 
}

//MARK:- 设置UI界面
extension PassageViewController {
    fileprivate func setupUI(){
        gradient.frame = view.frame
        gradient.colors = colorses[0]
        carousel.layer .insertSublayer(gradient, at: 0)
        carousel.type = .coverFlow2
        carousel.scrollSpeed = 0.7
    }
}
//MARK:- 监听点击数据
extension PassageViewController {
    //刷新
    @IBAction func refreshItemClick(_ sender: AnyObject) {
        passageVM.passageModels.removeAll()
        currentPage = 1
        loadData()
    }
    //复制
    @IBAction func exportItemClick(_ sender: AnyObject) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "保存本条到剪贴板", style: .default, handler: { (_) in
            let pasteboard = UIPasteboard.general
            let passage = self.passageVM.passageModels[self.carousel.currentItemIndex]
            pasteboard.string = passage.content
            HUD.flash(.labeledSuccess(title: "保存成功", subtitle: nil), delay: 1)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}

//MARK:- 请求数据
extension PassageViewController {
    fileprivate func loadData(){
        HUD.show(.progress)
        passageVM.loadPassageData {
            HUD.hide()
            self.carousel.reloadData()
            if (self.currentPage == 1) {
                self.carousel.scrollToItem(at: 0, animated: false)
            }
        }
    }
}

//MARK:- iCarousel数据源&代理
extension PassageViewController: iCarouselDataSource,iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return passageVM.passageModels.count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView{
        var itemView: UIView
        var label: UILabel
        if let view = view {
            itemView = view
            label = itemView.viewWithTag(1) as! UILabel
        }else{
            itemView = UIView(frame: CGRect(x: 0, y: 0, width: (self.view?.bounds.width)! * 0.7, height: (self.view?.bounds.height)! * 0.6))
            itemView.layer.cornerRadius = 5
            itemView.layer.masksToBounds = true
            itemView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            itemView.alpha = 0.9
            label = UILabel(frame: CGRect(x: 0, y: 0, width: itemView.bounds.width * 0.9, height: itemView.bounds.height * 0.9))
            label.center = itemView.center
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 0
            label.textColor = UIColor(r: 90, g: 90, b: 90)
            label.tag = 1
            itemView.addSubview(label)

        }
        let passageModel = passageVM.passageModels[index]
        
        label.text = passageModel.content + "\n\n" + Date.createDateString(passageModel.time)
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.4
        }
        return value
    }
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        gradient.colors = colorses[Int(arc4random())%colorses.count]
        
    }

    func carouselDidScroll(_ carousel: iCarousel){
        if (Int(carousel.scrollOffset) + 1)/10 == currentPage {
            currentPage += 1
//            print("++++")
            HUD.show(.progress)
            passageVM.loadPassageData(currentPage, finishedCallBack: {
                HUD.hide()
                carousel.reloadData()
            })
        }
    }
}
