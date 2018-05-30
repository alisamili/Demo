//
//  MINavigationController.swift
//  P2PSwiftDemo
//
//  Created by sangfor on 2018/5/22.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class MINavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true;
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem().barButtonItemWith(Target: self, Aciton: #selector(pressBack), NormalImage: UIImage(named:"")!, HighLightedImage: UIImage(named:"")!)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func pressBack() {
        self.popViewController(animated: true)
    }
}
