//
//  UIBarButtonItem+Extension.swift
//  P2PSwiftDemo
//
//  Created by sangfor on 2018/5/22.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func barButtonItemWith(Target target:Any?, Aciton action:Selector?, NormalImage normalImage:UIImage?, HighLightedImage highLightImage:UIImage?) -> UIBarButtonItem {
        let btn = UIButton(type:.custom)
        if target != nil && action != nil {
            btn.addTarget(target, action: action!, for: .touchUpInside)
        }
        if normalImage != nil {
            btn.setBackgroundImage(normalImage, for: .normal)
        }
        
        if highLightImage != nil {
            btn.setBackgroundImage(highLightImage, for: .highlighted)
        }
        return UIBarButtonItem(customView: btn)
    }
}
