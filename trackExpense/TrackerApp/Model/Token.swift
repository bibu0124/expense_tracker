//
//  Token.swift
//  VietApp
//
//  Created by Admin on 20/03/2023.
//

import Foundation
import Codextended


struct Token {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    fileprivate let userDefaults: UserDefaults
    static let shared = Token()
    var userId: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kAccessToken.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kAccessToken.rawValue)
            userDefaults.synchronize()
        }
    }
    
    
    var tokenExists: Bool {
        return !self.userId.isNilOrEmpty
    }
    
    
    var user: UserModel? {
        get {
            if let data = userDefaults.object(forKey: UserDefaultKey.kCurUser.rawValue) as? Data , let configData = try? decoder.decode(UserModel.self, from: data) {
                return configData
            }
            return nil
        }
        set {
            if let encoded = try? encoder.encode(newValue) {
                userDefaults.set(encoded, forKey: UserDefaultKey.kCurUser.rawValue)
                userDefaults.synchronize()
            }
        }
    }
    
    var role: APP_ROLE? {
        get {
            if let data = userDefaults.object(forKey: UserDefaultKey.kRole.rawValue) as? Data , let configData = try? decoder.decode(APP_ROLE.self, from: data) {
                return configData
            }
            return nil
        }
        set {
            if let encoded = try? encoder.encode(newValue) {
                userDefaults.set(encoded, forKey: UserDefaultKey.kRole.rawValue)
                userDefaults.synchronize()
            }
        }
    }
    
    var isFlowRegister: Bool? {
        get {
            return userDefaults.bool(forKey: UserDefaultKey.kFlowRegister.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kFlowRegister.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var current_language: String? {
        get {
            return userDefaults.string(forKey: "UserDefaultKey.kLanguage.rawValue") ?? "vi"
        }
        set {
            userDefaults.set(newValue, forKey: "UserDefaultKey.kLanguage.rawValue")
            userDefaults.synchronize()
        }
    }
    
    var isCompleteGuide: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultKey.kCompleteGuide.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kCompleteGuide.rawValue)
            userDefaults.synchronize()
        }
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func clear() {
        for key in UserDefaultKey.allCases {
            userDefaults.removeObject(forKey: key.rawValue)
            userDefaults.synchronize()
        }
        
    }
}

enum UserDefaultKey: String, CaseIterable {
    case kAccessToken = "access_token"
    case kDeviceToken = "device_token"
    case kUserID = "kUserID"
    case kCurUser = "USER"
    case kAddress = "ADDRESS"
    case kEmail = "didEmailUser"
    case kPassword = "didPasswordUser"
    case kName = "didNameUser"
    case kFacebookId = "didFacebookIdUser"
    case kGoogleId = "didGoogleIdUser"
    case kAvatar = "didAvatarUser"
    case kCompleteGuide = "kCompleteGuide"
    case kCurrentAppVersion = "kCurrentAppVersion"
    case kUserInToken = "kUserInToken"
    case kStates = "kStates"
    case kPassWord = "kPassWord"
    case kInSessionApp = "kInSessionApp"
    case kRole = "kRole"
    case kFlowRegister = "kFlowRegister"

}
