//
//  LoginViewController.swift
//  P2PSwiftDemo
//
//  Created by sangfor on 2018/5/24.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import UIKit

class LoginViewController: P2PBaseViewController, UITextFieldDelegate {

    var mobileTextField:UITextField?
    var passwordTextField:UITextField?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
    }
    
    func createUI() {
        let cancelBtn = P2PUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:20, y:Int(CGFloat.statusBarHeight) + 5, width:30, height:30), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cancelBtnAction), TextAligtment: nil)
        cancelBtn.setImage(UIImage(named:""), for: .normal)
        self.view.addSubview(cancelBtn)
        
        let headImageView  = P2PUtil.createImageViewWith(Frame: CGRect(x:(SCREEN_WIDTH-160)/2, y:100, width:160, height:54), ImageName: "矢量智能对象", CornarRadius: 0.0)
        self.view.addSubview(headImageView)
        
        let mobileImageView = P2PUtil.createImageViewWith(Frame: CGRect(x:30,y:headImageView.frame.maxY + 50, width:26,height:26), ImageName: "手机", CornarRadius: 0.0)
        self.view.addSubview(mobileImageView)
        
        let mobileTextField = P2PUtil.createTextFieldWith(Frame: CGRect(x:mobileImageView.frame.maxX+20, y:mobileImageView.frame.maxY+42,width:SCREEN_WIDTH-114,height:45), BoardStyle: .none, PlaceHolder: "请输入手机号", BackgroundColor: UIColor.clear, TintColor: UIColor.initColor, IsPWD: false)
        mobileTextField.delegate = self
        self.view.addSubview(mobileTextField)
        
        let lineViewOne = P2PUtil.createViewWith(Frame: CGRect(x:10, y:(mobileTextField.frame.maxY)+5, width:SCREEN_WIDTH - 20, height:1), BackgroundColor: UIColor.mainWhiteColor)
        self.view.addSubview(lineViewOne)
    
        let passImageView = P2PUtil.createImageViewWith(Frame: CGRect(x:30, y:lineViewOne.frame.maxY + 15,width:26, height:26), ImageName: "密码图", CornarRadius: 0.0)
        self.view.addSubview(passImageView)
        
        let passwordTextField = P2PUtil.createTextFieldWith(Frame: CGRect(x:30,y:passImageView.frame.maxY+15,width:SCREEN_WIDTH-114,height:45), BoardStyle: .none, PlaceHolder: "请输入登录密码", BackgroundColor: UIColor.clear, TintColor: UIColor.initColor, IsPWD: true)
        passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        
        let lineViewTwo = P2PUtil.createViewWith(Frame: CGRect(x:10, y:(passwordTextField.frame.maxY) + 5, width:SCREEN_WIDTH - 20, height:1), BackgroundColor: UIColor.mainWhiteColor)
        self.view.addSubview(lineViewTwo)
        
        let loginBtn = P2PUtil.createButtonWith(Type: .custom, Title: "登录", Frame: CGRect(x:15, y:lineViewTwo.frame.maxY+40, width:SCREEN_WIDTH - 30, height:50), TitleColor: UIColor.white, Font: 20.0, BackgroundColor: UIColor.initColor, Target: self, Action: #selector(login), TextAligtment: .center)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.shadowOffset = CGSize(width:0,height:5)
        loginBtn.layer.shadowOpacity = 0.5
        loginBtn.layer.shadowColor = UIColor.initColor.cgColor
        self.view.addSubview(loginBtn)
        
        let registerBtn = P2PUtil.createButtonWith(Type: .custom, Title: "注册", Frame: CGRect(x:15, y:loginBtn.frame.maxY + 20, width:50, height:30), TitleColor: UIColor.labelTextColor, Font: 15, BackgroundColor: UIColor.clear, Target: self, Action: #selector(pushRegisterVC), TextAligtment: .left)
        self.view.addSubview(registerBtn)
        
        let forgetPasswordBtn = P2PUtil.createButtonWith(Type: .custom, Title: "忘记密码？", Frame: CGRect(x:SCREEN_WIDTH-115,y:loginBtn.frame.maxY+20,width:100,height:30), TitleColor: UIColor.labelTextColor, Font: 15, BackgroundColor: UIColor.clear, Target: self, Action: #selector(pushForgetPasswordVC), TextAligtment: .right)
        self.view.addSubview(forgetPasswordBtn)
        
    }
    @objc func pushRegisterVC() {
        
    }
    
    @objc func pushForgetPasswordVC() {
        
    }
    @objc func cancelBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func login() {
        if (mobileTextField?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "请输入账号！")
        } else if (passwordTextField?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "请输入密码！")
        } else {
            SVProgressHUD.show()
            
        }
    }
}
