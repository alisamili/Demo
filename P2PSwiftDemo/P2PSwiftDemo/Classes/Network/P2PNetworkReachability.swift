//
//  P2PNetworkReachability.swift
//  P2PSwiftDemo
//
//  Created by sangfor on 2018/5/25.
//  Copyright © 2018年 sangfor. All rights reserved.
// 网络监听类

import UIKit

class P2PNetworkReachability: NSObject {
    static let reachAbility = P2PNetworkReachability()
    var reachAble:Bool = {
        var reach = true
        let manager = NetworkReachabilityManager(host:"www.baidu.com")
        
        manager?.listener = { status in
            switch status {
            case .notReachable:
                reach = false
                SVProgressHUD.showError(withStatus: "网络出错")
            case .reachable(.ethernetOrWiFi):
                reach = true
            case .reachable(.wwan):
                reach = true
            case .unknown:
                reach = false
                SVProgressHUD.showError(withStatus: "网络出错")
            }
        }
        //开始监听
        manager?.startListening()
        return reach
    }()
    
}
