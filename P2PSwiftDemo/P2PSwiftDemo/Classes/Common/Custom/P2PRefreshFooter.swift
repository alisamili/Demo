//
//  P2PRefreshFooter.swift
//  P2PSwiftDemo
//
//  Created by Alisa on 2018/6/1.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class P2PRefreshFooter: MJRefreshBackGifFooter {

    override func prepare() {
        
            super.prepare()
            var idleImages = [UIImage]()
            for i in 1...60 {
                let image = UIImage(named: "reload_0\(i)")
                idleImages.append(image!)
            }
            self.setImages(idleImages, for: .idle)
            
            var refreshImages = [UIImage]()
            for i in 1...6 {
                let image = UIImage(named: "reload_refresh0\(i)")
                refreshImages.append(image!)
            }
            self.setImages(refreshImages, for: .pulling)
            self.setImages(refreshImages, for: .refreshing)
            
        
    }

}
