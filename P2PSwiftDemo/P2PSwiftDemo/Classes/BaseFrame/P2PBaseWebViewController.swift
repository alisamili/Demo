//
//  P2PBaseWebViewController.swift
//  P2PSwiftDemo
//
//  Created by Alisa on 2018/5/28.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit
import WebKit
class P2PBaseWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webView:WKWebView?
    var link = ""
    var webTitle = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建UI
        createToolBar()
        createUI()
    }

    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.tintColor = UIColor.tabbarInitColor
        toolBar.backgroundColor = UIColor.white
        
        let h = SCREEN_HEIGHT - TABBAR_HEIGHT
        toolBar.frame = CGRect(x: 0, y: h, width: SCREEN_WIDTH, height: TABBAR_HEIGHT)
        self.view.addSubview(toolBar)
        
        let backItem = UIBarButtonItem.init(image: UIImage(named: ""), style: .plain, target: self, action:#selector(goBack))
        
        let forwardItem = UIBarButtonItem.init(image: UIImage(named: ""), style: .plain, target:self, action:#selector(goForward))
        
        let refreshItem = UIBarButtonItem.init(image: UIImage(named: ""), style: .plain, target:self, action:#selector(refreash))
        toolBar.items = [backItem, forwardItem, refreshItem]
        
        
        
        
    }
    
    func createUI(){
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT))
        self.view.addSubview(webView!)
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        webView?.load(request)
        
        
    }
    
    @objc func goBack(){
        webView?.goBack()
    }
    
    @objc func goForward(){
        webView?.goForward()
    }
    
    @objc func refreash(){
        webView?.reload()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
