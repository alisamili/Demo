//
//  VariableDefineFile.swift
//  swiftDemo
//
//  Created by sangfor on 2018/5/22.
//  Copyright © 2018年 sangfor. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_MAX_LENGTH  = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let IS_IPHONE_4_OR_LESS = SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = SCREEN_MAX_LENGTH == 812.0

let STATUS_NAV_BAR_Y:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0
let TABBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 83.0 : 49.0
let STATUSBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 44.0 : 20.0



/*
 * 颜色
 */
extension UIColor {
    static let initColor = UIColor(red: 164.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
    static let tabbarInitColor = UIColor(red: 237.0/255, green: 31.0/255, blue: 59.0/255, alpha: 1.0)
    static let mainWhiteColor = UIColor(red: 242.0/255, green: 242.0/255, blue: 242.0/255, alpha: 1.0)
    static let labelTextColor = UIColor.gray
    static let investPersonColor = UIColor(red: 34.0/255, green: 160.0/255, blue: 43.0/255, alpha: 1.0)
    static let investComColor = UIColor(red: 237.0/255, green: 31.0/255, blue: 59.0/255, alpha: 1.0)
    static let investNewColor = UIColor(red: 253.0/255, green: 143.0/255, blue: 27.0/255, alpha: 1.0)
    static let binBackColor = UIColor(red: 18.0/255, green: 147.0/255, blue: 255.0/255, alpha: 1.0)
    static let labelBackColor = UIColor(red: 30.0/255, green: 30.0/255, blue: 30.0/255, alpha: 1.0)
    static let navigationBarColor = UIColor(red: 232.0/255, green: 55.0/255, blue: 64.0/255, alpha: 1.0)
}

