//
//  P2PSegment.swift
//  P2PSwiftDemo
//
//  Created by Alisa on 2018/6/8.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class P2PSegment: UIView {

    var titleArray:Array<Any>?{
        didSet{
            createUI()
        }
    }
    
    
    var buttonClickEvent:((Int) -> Void)?
    
    func createUI(){
        let width = Int(self.frame.size.width) - (titleArray?.count)! * 70
        let margin = width / ((titleArray?.count)! + 1)
        for i in 0..<(titleArray?.count)! {
            let button = P2PUtil.createButtonWith(Type: .custom, Title: titleArray?[i] as? String, Frame: CGRect(x: margin + i * (70 + margin), y: 0, width: 70, height: Int(self.frame.size.height)), TitleColor: UIColor.labelTextColor, Font: 12, BackgroundColor: UIColor.clear, Target: self, Action: #selector(buttonClick(_:)), TextAligtment: .center)
            button.tag = i + 1
            self.addSubview(button)
            let lineView = P2PUtil.createViewWith(Frame: CGRect(x: margin + i * (70 + margin), y: Int(self.frame.height - 2), width: 70, height: 2), BackgroundColor: UIColor.clear)
            lineView.tag = i + 11
            self.addSubview(lineView)
            
            if i == 0 {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                button.setTitleColor(UIColor.tintColor, for: .normal)
                lineView.backgroundColor = UIColor.tintColor
            }
        }
    }
    
    @objc func buttonClick(_ sender:Any) {
        let button = sender as! UIButton
        if buttonClickEvent != nil {
            buttonClickEvent!(button.tag - 1)
        }
        changeButtonAndLineStatus(button.tag)
    }

    
    
    func changeButtonAndLineStatus(_ tag:Int){
        for subView in self.subviews {
            if subviews is UIButton {
                if subView.tag != tag {
                    let btn = subView as! UIButton
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    btn.setTitleColor(UIColor.labelTextColor, for: .normal)
                } else {
                    let btn = subView as! UIButton
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    btn.setTitleColor(UIColor.tintColor, for: .normal)
                }
            }
        }
        
            for subView in self.subviews {
                if (!(subView is UIButton)) {
                    if subView.tag != tag + 10 {
                    subView.backgroundColor = UIColor.clear
                } else {
                    subView.backgroundColor = UIColor.tintColor
                }
            }
        }
    }
}
