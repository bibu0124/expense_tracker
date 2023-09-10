//
//  Service_API.swift
//  VietApp
//
//  Created by Admin on 6/14/22.
//

import Foundation
///---------------------------------------------------------------------------------------
/// SERVER
///---------------------------------------------------------------------------------------
//MARK: - SERVER
let DOMAIN = "https://api.viet-edu.kennjdemo.com" //DEV
let DOMAIN2 = "https://api.viet-edu.kennjdemo.com" //DEV

let API = "api/v1/"
let SERVER = "\(DOMAIN)/\(API)"
let SERVER_SOCKET_API = "\(DOMAIN2):3009/\(API)"
let SERVER_SOCKET_IO = "\(DOMAIN2):3009/"
let POLICY = "\(DOMAIN)/policy"

class Service_API {
    static let FEED_API = "\(SERVER)post"
    static let FEED_API_AUTHEN = "\(SERVER)post/auth"
    static let CATEGORY_API = "\(SERVER)config/music-type"

}
