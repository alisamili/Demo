//
//  P2PRefreshHeader.swift
//  P2PSwiftDemo
//
//  Created by Alisa on 2018/5/31.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class P2PRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        var idleImages = [UIImage]()
        for i in 1...60 {
            let image = UIImage(named: "reload_0\(i)")
            idleImages.append(image!)
            
        }
        //普通闲置状态
        self.setImages(idleImages, for: .idle)
        var refreshImages = [UIImage]()
        for i in 1...6 {
            let image = UIImage(named: "reload_refresh0\(i)")
            refreshImages.append(image!)
            
        }
        //松开就可以进行刷新的状态
        self.setImages(refreshImages, for: .pulling)
        
        //正在刷新中的状态
        self.setImages(refreshImages, for: .refreshing)
        
        
    }

}
