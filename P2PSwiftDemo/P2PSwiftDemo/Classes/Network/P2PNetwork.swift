//
//  P2PNetwork.swift
//  P2PSwiftDemo
//
//  Created by sangfor on 2018/5/23.
//  Copyright © 2018年 sangfor. All rights reserved.
// 网络请求封装方法

import UIKit


class P2PNetwork: NSObject {

    struct responseData {
        var resquest : URLRequest?
        var response: HTTPURLResponse?
        var json:AnyObject?
        var error:NSError?
        var data:Data?
        
    }
    
    class func requestWith(Method method:HTTPMethod, URL url:String, Parameter para:[String:Any]?, Token token:String?, handler: @escaping(responseData) -> Void) {
        let reachAlbe = P2PNetworkReachability.reachAbility.reachAble
        if reachAlbe {
            var dictToken:[String:String]!
            if token != nil {
                dictToken = ["tokenId":token!]
            }
            let manager = SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 10
            manager.request(url, method: method, parameters: para, encoding: URLEncoding.default, headers: dictToken).response(completionHandler:
                {(response) in
                    let json:AnyObject! = try?JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as AnyObject
                    if nil != json {
                        let res = responseData(resquest:response.request, response:response.response, json:json, error:response.error as NSError?, data:response.data)
                        handler(res)
                        
                    }
            })
            
        }
        
    }
}
