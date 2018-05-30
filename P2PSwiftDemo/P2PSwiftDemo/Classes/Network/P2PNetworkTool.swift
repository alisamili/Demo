//
//  P2PNetworkTool.swift
//  P2PSwiftDemo
//
//  Created by sangfor on 2018/5/25.
//  Copyright © 2018年 sangfor. All rights reserved.
// 网络请求业务封装类

import UIKit

enum SmsCodeType{
    case register
    case forgetPass
}

class P2PNetworkTool: NSObject {
    static let networkTool = P2PNetworkTool()
    var codeType = SmsCodeType.register
    struct result {
        var success:Bool = false
        var message:String?
        var res_data:[String:Any]?
        var res_code:String?
    }
    
    var localPara:[String:Any] = ["devicetype":DEVICE_TYPE,"versioncode":APP_VERSION,"user_id":P2PUtil.GET_USER_DEFAULTS(Key: "userID")!,"appkey":APP_KEY,"ts":"\(P2PUtil.changeNowDateToTimeStamp())","oauth_token":P2PUtil.GET_USER_DEFAULTS(Key: "oauth_token")!,"signa":P2PUtil.md5(Str: "\(P2PUtil.md5(Str: "\(FRONT_SALT)\(P2PUtil.changeNowDateToTimeStamp())"))\(BEHIND_SALT)".uppercased())]
    
    func handleResponse(JSON json:JSON) -> result {
        if P2PUtil.isBlankString(String: json["res_msg"].string) != "" {
            SVProgressHUD.show()
        }
        return result(success: true, message: json["res_msg"].string, res_data: json["res_data"].dictionary, res_code: json["res_code"].string)
    }
    
    //登录
    func loginWith(MobileNum num:String, Password pass:String, Handler completeHandler:@escaping((result) -> Void)) {
        localPara["id"] = num
        localPara["pwd"] = P2PUtil.encodingBase64(String: pass)
        P2PNetwork.requestWith(Method: .post, URL: HOST + LOGIN_APT, Parameter: localPara, Token: nil){ (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
            }catch{}
        }
    }
    
    //首页
    func requestMainVCData(_ completeHandler:@escaping((result) -> Void)){
        P2PNetwork.requestWith(Method: .post, URL: HOST + MAIN_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            } catch{}
        }
    }
    
    //获取注册，忘记密码图片验证码
    func getRegisterPictureCode(_ completeHandler:@escaping((String, Data) -> Void)){
        P2PNetwork.requestWith(Method: .post, URL: HOST + REGISTER_PIC_CODE_API, Parameter: localPara, Token: nil) { (res) in
            let dic:Dictionary = (res.response?.allHeaderFields)!
            if dic.keys.contains("captchaToken") {
                completeHandler(dic["captchaToken"] as! String, res.data!)
            }
        }
    }
    
    //注册，忘记密码获取文字验证码
    func getSmsCodeWith(Dic dic:Dictionary<String, String>, completeHandler:@escaping((result) -> Void)){
        var localDic = localPara as [String:Any]
        for (key,value) in dic {
            localDic[key] = value
        }
        
        var urlString = ""
        switch codeType {
        case .forgetPass:
            urlString = HOST + FORGET_PASS_SMS_CODE_API
            break
        case .register:
            urlString = HOST + REGISTER_SMS_CODE_API
            break
        }
        
        P2PNetwork.requestWith(Method: .post, URL: urlString, Parameter: localDic, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
            }catch{}
        }
    }
    
    //注册
    func registerWith(PhoneNum phoneNum:String, InvestCode investCode:String?, SmsCode smscode:String, UserType type:String, Password password:String, completeHandler:@escaping((result) -> Void)){
        localPara["phone"] = phoneNum
        localPara["invite_code"] = investCode
        localPara["code"] = smscode
        localPara["userNature"] = type
        localPara["pwd"] = password
        P2PNetwork.requestWith(Method: .post, URL: HOST + REGISTER_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
            }catch{}
        }
    }
    
    
    //忘记密码第一步验证手机号码
    func checkMobilePhoneWhenForgetPassword(PhoneNum phoneNum:String, SmsCode smscode:String, completeHandler:@escaping((result) -> Void)){
        localPara["phone_or_email"] = phoneNum
        localPara["code"] = smscode
        P2PNetwork.requestWith(Method: .post, URL: HOST + FORGET_PASS_FIRST_STEP_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            } catch{}
        }
    }
    
    
    //忘记密码后修改密码
    func changePasswordWith(PhoneNum phoneNum:String, Password password:String, Session_id session_id:String, completeHandler:@escaping(result) ->Void) {
        localPara["phone_or_email"] = phoneNum
        localPara["pwd"] = P2PUtil.encodingBase64(String: password)
        localPara["session_id"] = session_id
        P2PNetwork.requestWith(Method: .post, URL: HOST + CHANGE_PASSWORD_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
            }catch{}
        }
    }
    
    //出借列表
    func getInvestListWith(Category category:String, Page page:String, completeHandler:@escaping((result) -> Void)){
        localPara["page"] = page
        localPara["productCategory"] = category
        localPara["pagesize"] = "10"
        P2PNetwork.requestWith(Method: .post, URL: HOST + INVEST_LIST_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            }catch{}
        }
    }
    
    //绑卡 cunguan连接
    
    func getCunguanUrlWith(UserType type:String, completeHandler:@escaping((result) -> Void)){
        localPara["userRole"] = type
        P2PNetwork.requestWith(Method: .post, URL: HOST + CUNGUAN_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            }catch{}
        }
    }
    
    //获取出借订单号
    func getInvestNoWith(InvestID investId:String, Money money:String, RateID rateId:String, UserID userId:String = P2PUtil.GET_USER_DEFAULTS(Key: "userID") as! String, UuID uuid:String, SessionID session_id:String,IsRewardInvest isRewardInvest:String,RedBonusID bonusId:String, InterestID interestId:String, UseTaste useTaste:String, CheckPass checkPass:String, DoubleReturnType doubleReturnType:String,completeHandler:@escaping((result) -> Void)) {
        localPara["pwd"] = checkPass
        localPara["experienceId"] = useTaste
        localPara["rateId"] = rateId
        localPara["id"] = investId
        localPara["money"] = money
        localPara["paypwd"] = ""
        localPara["user_id"] = userId
        localPara["uuid"] = uuid
        localPara["up_rate_id"] = rateId
        localPara["isRewardInvest"] = isRewardInvest
        localPara["doInvestAgain"] = "F"
        localPara["doubleReturnType"] = doubleReturnType
        P2PNetwork.requestWith(Method: .post, URL: HOST + GET_INVEST_NO, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            }catch{}
        }
    }
    
    //检查定向标密码是否正确
    func checkDirectInvestPass(Password pass:String, UUID uuid:String, InvestID investId:String, completeHandler:@escaping((result) -> Void)){
        localPara["uuid"] = uuid
        localPara["id"] = investId
        localPara["pwd"] = pass
        P2PNetwork.requestWith(Method: .post, URL: HOST + CHECK_PWD, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
                
            }catch{}
        }
    }
    
    //出借详情
    func getInvestDetailWith(UserID userId:String, UUID uuid:String, NID nid:String, completeHandler:@escaping((result) ->Void)) {
        localPara["id"] = nid
        localPara["uuid"] = uuid
        P2PNetwork.requestWith(Method: .post, URL: HOST + INVEST_DETAIL, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            }catch{}
        }
    }
    
    //上划后出借详情
    func getInvestDetailAfterUpSwipWith(UUID uuid:String, TypeID typeId:String, completeHandler:@escaping((result) -> Void)){
        localPara["uuid"] = uuid
        localPara["borrowType"] = typeId
        P2PNetwork.requestWith(Method: .post, URL: HOST + INVEST_DEFAIL_DEATIL, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
            }catch{}
        }
    }
    
    
    //出借记录
    func getInvestHistoryWith(UUID uuid:String, NID nid:String, Page page:String, completeHandler:@escaping((result) -> Void)){
        localPara["page"] = page
        localPara["pagesize"] = "10"
        localPara["id"] = nid
        P2PNetwork.requestWith(Method: .post, URL: HOST + INVEST_HISTORY, Parameter: localPara, Token: nid) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                    
                }
            }catch{}
        }
    }
    
    //个人中心
    func getMineData(completeHandler:@escaping((result) ->Void)){
        P2PNetwork.requestWith(Method: .post, URL: HOST + MINE_CENTER_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data: res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    completeHandler(aResult)
                }
            }catch{}
        }
    }
}
