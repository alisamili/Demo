//
//  P2PPictureShow.swift
//  P2PSwiftDemo
//
//  Created by Alisa on 2018/6/12.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class P2PPictureShow: UIView {

    static let picture = P2PPictureShow()
    var oldFrame:CGRect?
    
    func show(ImageView imageView:UIImageView){
        let image = imageView.image
        let window = UIApplication.shared.keyWindow
        let backgroundView = P2PUtil.createViewWith(Frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), BackgroundColor: UIColor.black)
        backgroundView.alpha = 0
        
        oldFrame = imageView.convert(imageView.bounds, to: window)
        let newImageView = P2PUtil.createImageViewWith(Frame: oldFrame!, ImageName: "", CornarRadius: 0)
        newImageView.image = image
        newImageView.tag = 1
        backgroundView.addSubview(newImageView)
        window?.addSubview(backgroundView)
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide(Tap:))))
        
        UIView.animate(withDuration: 0.3) {
            imageView.frame = CGRect(x: 0, y:(UIScreen.main.bounds.size.height-(image?.size.height)!*UIScreen.main.bounds.size.width/(image?.size.width)!)/2, width: UIScreen.main.bounds.size.width, height: (image?.size.height)!*UIScreen.main.bounds.size.width/(image?.size.width)!)
            backgroundView.alpha = 1
        }
    }
    
    @objc func hide(Tap tap:UITapGestureRecognizer){
        let backgroundView = tap.view
        let imageView = backgroundView?.viewWithTag(1) as! UIImageView
        UIView.animate(withDuration: 0.3, animations: {
            imageView.frame = self.oldFrame!
            backgroundView?.alpha = 0
            
        }) { (finish) in
            backgroundView?.removeFromSuperview()
            
        }
    }
}
