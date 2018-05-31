//
//  P2PAlertLabel.swift
//  P2PSwiftDemo
//
//  Created by Alisa on 2018/6/1.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class P2PAlertLabel: UIView {

    convenience init(frame: CGRect, Text text:String, DIsmissTime dismissTime:Int) {
        self.init(frame: frame)
        
        let  label = P2PUtil.createLabelWith(Text: text, Frame: frame, TextColor: UIColor.white, Font: 14, TextAligtment: .center)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true
        self.addSubview(label)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(dismissTime)), execute: {
            self.removeFromSuperview()
        })
        
    }

}
