//
//  MITabbarControl.swift
//  swiftDemo
//
//  Created by sangfor on 2018/5/22.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit


class MITabbarControl: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.addChildViewController()
        
    }
    
    func addChildViewController(ChildController child:UIViewController, Title title:String, DefaultImage defaultImage:UIImage, SelectedImage selectedImage:UIImage) {
        child.tabBarItem = UITabBarItem(title: title, image:defaultImage.withRenderingMode(.alwaysOriginal), selectedImage:selectedImage.withRenderingMode(.alwaysOriginal))
        child.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.tabbarInitColor], for: .selected)
        let nav = MINavigationController(rootViewController: child)
        self.addChildViewController(nav)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.title == "我的账号" {
            if !((P2PUtil.GET_USER_DEFAULTS(Key: "userID") as! String).isEmpty) && !((P2PUtil.GET_USER_DEFAULTS(Key: "oauth_token") as! String).isEmpty) && !((P2PUtil.GET_USER_DEFAULTS(Key: "refresh_token") as! String).isEmpty) && !((P2PUtil.GET_USER_DEFAULTS(Key: "isLogin") as! String).isEmpty) {
                return true
            } else {
                let alert:TYAlertView = TYAlertView(title:"系统提示", message:"未登录，请登录！")
                alert.buttonDefaultBgColor = UIColor.initColor
                alert.add(TYAlertAction(title:"取消", style: .default, handler:{
                    (action) in
                }))
                alert.add(TYAlertAction(title:"确定", style: .default, handler:{
                    (action) in
                    let loginVC = LoginViewController()
                    loginVC.hidesBottomBarWhenPushed = true
                    let nav = tabBarController.selectedViewController as! UINavigationController
                    nav.pushViewController(loginVC, animated: true)
                
                }))
//                alert.show()
                return false
            }
        } else {
            return true
        }
    }
}
