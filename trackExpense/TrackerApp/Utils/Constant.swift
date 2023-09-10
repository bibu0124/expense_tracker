//
//  Constant.swift
//  VietApp
//
//  Created by Admin on 6/13/22.
//

import UIKit
///---------------------------------------------------------------------------------------
/// SCREEN FRAME
///---------------------------------------------------------------------------------------
//MARK: - SCREEN FRAME
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPAD: Bool = (UIDevice.current.userInterfaceIdiom == .pad)
let IS_IPHONE: Bool = (UIDevice.current.userInterfaceIdiom == .phone)
let IS_IPHONE_X: Bool = (IS_IPHONE&&(SCREEN_MAX_LENGTH >= 812.0))


///---------------------------------------------------------------------------------------
/// NOTIFICATION
///---------------------------------------------------------------------------------------
//MARK: - NOTIFICATION
extension Notification.Name {
    static let didUpdateSaveLocal = Notification.Name("didUpdateSaveLocal")
    static let flagsChangedInternet = Notification.Name("flagsChangedInternet")
    static let turnOffVideo = Notification.Name("turnOffVideo")
    static let updateProgressBarVideoAWS = Notification.Name("updateProgressBarVideoAWS")

    
}

let NUNITO_MEDIUM = "Nunito-Medium"
let NUNITO_REGULAR = "Nunito-Regular"
let SHARE_APPLICATION_DELEGATE = UIApplication.shared.delegate as! AppDelegate

let APP_GENDER = [BasePicker(id : 0, title: "Nam"),
                  BasePicker(id : 1, title: "Nữ")]
let DATE_API_DEFAULT = "yyyy-MM-dd HH:mm:ss"
let DATE_TIME_FORMAT = "HH:mm MM/dd/yyyy"
let DATE_FORMAT = "yyyy-MM-dd"
let TIME_FORMAT = "HH:mm"
let DATE_TICKET_FORMAT = "MM/dd/yyyy"
let DATE_APP_FORMAT = "dd-MM-yyyy"
let NORMAL_APP_FORMAT = "dd / MM / yyyy"
let DATETIME_APP_FORMAT = "HH:mm-dd/MM/yyyy"
let DATETIME_CARD_FORMAT = "MM/yyyy"

enum InformationType: Int {
    case SHOW = 0
    case PAYMENT = 1
    case CARD = 2
}

enum APP_ROLE : Int, Codable {
    case customer = 1
    case artist = 2
}
let GG_API_KEY = "AIzaSyC5ClNJK9WT_UduTdKBlKbNQcw746YUY70"
let GOOGLEMAP_KEY = "AIzaSyC6QGlt0uXJ3y3rr7ScNy83itEugmmNC1E"
let valueForReplace = "{{Value}}"
let PHONE_FORMAT_NEW = "(***) ***-****"
let CHARACTER_FORMAT = "*".utf16.first!
let PHONE_NUMBER = "****-***-***"
let CARD_NUMBER = "**** **** **** ****"
let CARD_EXPIRED_TIME = "**/**"
let CARD_CVC = "****"
let MIN_WITHDAW = 50000
let MIN_PAYMENT = 15000
let APP_TEXT_COLOR = #colorLiteral(red: 0.9991758466, green: 0.4186979234, blue: 0.4249164462, alpha: 1)
let APP_SILVER_COLOR = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
let APP_CLEAN_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)

let IMG_LOGO_PLACEHOLDER = UIImage(named: "ic_placeholder_logo")

let MAX_PRICE : Double = 10000000// 9999999
