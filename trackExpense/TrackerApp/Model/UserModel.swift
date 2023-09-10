//
//  UserModel.swift
//  VietApp
//
//  Created by Admin on 6/11/22.
//

import Foundation

struct AuthResponseModel : Codable {
    var token: String?
    var user: UserModel?
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        user = try? decoder.decode("user")
        token = try? decoder.decode("token")
    }
}
struct UserModel : Codable {
    
    var id : Int?
    var fullname : String?
    var email : String?
    var phone : String?
    var gender : Int?
    var birthday : String?
    var address : String?
    var google_id : String?
    var facebook_id : String?
    var latitude : String?
    var longitude : String?
    var city : String?
    var state : String?
    var zipcode : String?
    var type : Int?
    var expiried_trial_at : String?
    var last_login : String?
    var language : String?
    var token : String?
    var avatar_url : String?
    var need_update_profile : Int?
    
    
    
    //extend
    
    init(from decoder: Decoder) throws {
        id = try? decoder.decodeIfPresent("id")
        need_update_profile = try? decoder.decodeIfPresent("need_update_profile")
        fullname = try? decoder.decodeIfPresent("fullname")
        email = try? decoder.decodeIfPresent("email")
        phone = try? decoder.decodeIfPresent("phone")
        gender = try? decoder.decodeIfPresent("gender")
        birthday = try? decoder.decodeIfPresent("birthday")
        address = try? decoder.decodeIfPresent("address")
        google_id = try? decoder.decodeIfPresent("google_id")
        facebook_id = try? decoder.decodeIfPresent("facebook_id")
        latitude = try? decoder.decodeIfPresent("latitude")
        longitude = try? decoder.decodeIfPresent("longitude")
        city = try? decoder.decodeIfPresent("city")
        zipcode = try? decoder.decodeIfPresent("zipcode")
        state = try? decoder.decodeIfPresent("state")
        type = try? decoder.decodeIfPresent("type")
        expiried_trial_at = try? decoder.decodeIfPresent("expiried_trial_at")
        last_login = try? decoder.decodeIfPresent("last_login")
        language = try? decoder.decodeIfPresent("language")
        token = try? decoder.decodeIfPresent("token")
        avatar_url = try? decoder.decodeIfPresent("avatar_url")
        
        
    }
    
    init(){
        
    }
    
}

struct VerifyPasswordModel: Codable {
    
    var phone: String?
    var fullname: String?
    var type: Int?
    var id: Int?
    var avatar_url: String?
    
    init(from decoder: Decoder) throws {
        phone = try? decoder.decode("phone")
        fullname = try? decoder.decode("fullname")
        type = try? decoder.decode("type")
        id = try? decoder.decode("id")
        avatar_url = try? decoder.decode("avatar_url")
    }
    
}

