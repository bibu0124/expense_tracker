//
//  BaseNavigationController.swift
//  VietApp
//
//  Created by Admin on 6/13/22.
//

import Alamofire

class APIServices: NSObject {
    
    static let shared = APIServices()
    
    //MARK: - AUTH SERVICES
    func verifyPhoneCode(parameters : [String : Any]?, completion: @escaping ((_ model: BaseModel<AuthResponseModel>?)->Void)) {
        let url = SERVER + "user/check-verify-code"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseModel<AuthResponseModel>.self, encoding: JSONEncoding.default) { ( data) in
            guard let model = data as? BaseModel<AuthResponseModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func forgotPassword(parameters : [String : Any]?, completion: @escaping ((_ model: BaseResponse?)->Void)) {
        let url = SERVER + "user/verify-phone"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseResponse.self, encoding: JSONEncoding.default) { (data) in
            guard let model = data as? BaseResponse else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func login(parameters : [String : Any]?, completion: @escaping ((_ model: BaseModel<AuthResponseModel>?) -> Void)) {
        let url = SERVER + "user/login"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseModel<AuthResponseModel>.self, encoding: JSONEncoding.default) { ( data) in
            guard let model = data as? BaseModel<AuthResponseModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    
    func register(parameters : [String : Any]?, completion: @escaping ((_ model: BaseModel<UserModel>?) -> Void)) {
        let url = SERVER + "user/register"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseModel<UserModel>.self, encoding: JSONEncoding.default) { ( data) in
            guard let model = data as? BaseModel<UserModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }

    func deleteAccount(parameters : [String : Any]?, completion: @escaping ((_ model: BaseModel<UserModel>?) -> Void)) {
        let url = SERVER + "user/delete-account"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseModel<UserModel>.self, encoding: JSONEncoding.default) { ( data) in
            guard let model = data as? BaseModel<UserModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func getProfileCustomer(id: Int?, _ completion: @escaping ((_ model: BaseModel<UserModel>?) -> Void)) {
        let url = SERVER + "user/\(id ?? 0)"
        RequestService.shared.requestWith(url, .get, nil, nil, objectType: BaseModel<UserModel>.self, encoding: URLEncoding.default) { ( data) in
            guard let model = data as? BaseModel<UserModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
//    func updateProfile(parameters : [String : Any]?, completion: @escaping ((_ model: BaseResponse?)->Void)) {
//        let url = SERVER + "user/update-profile"
//        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseResponse.self, encoding: JSONEncoding.default) { ( data) in
//            guard let model = data as? BaseResponse else {
//                completion(nil)
//                return
//            }
//            completion(model)
//        }
//    }
//
    func resetPassword(parameters : [String : Any]?, completion: @escaping ((_ model: BaseResponse?)->Void)) {
        let url = SERVER + "user/reset-password"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseResponse.self, encoding: JSONEncoding.default) { ( data) in
            guard let model = data as? BaseResponse else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func getProfile(parameters : [String : Any]?, completion: @escaping ((_ model: BaseModel<UserModel>?)->Void)) {
        let url = SERVER + "user/my-profile"
        RequestService.shared.requestWith(url, .get, parameters, nil, objectType: BaseModel<UserModel>.self, encoding: URLEncoding.default) { ( data) in
            guard let model = data as? BaseModel<UserModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func updateProfile(parameters : [String : Any]?, dataImages : [Dictionary<String, Any>]?, completion: @escaping ((_ model: BaseModel<UserModel>?)->Void)) {
        let url = SERVER + "user/update-profile"
        RequestService.shared.upload(url, .post, parameters, nil, objectType: BaseModel<UserModel>.self, dataImages: dataImages) { (data) in
            guard let model = data as? BaseModel<UserModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func logout(parameters : [String : Any]?, completion: @escaping ((_ model: BaseResponse?)->Void)) {
        let url = SERVER + "user/logout"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseResponse.self, encoding: JSONEncoding.default) { (data) in
            guard let model = data as? BaseResponse else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func listNotification(parameters : [String : Any]?, completion: @escaping ((_ model: BaseListModel<NotificationModel>?)->Void)) {
        let url = SERVER + "notification/my-notification"
        RequestService.shared.requestWith(url, .get, parameters, nil, objectType: BaseListModel<NotificationModel>.self, encoding: URLEncoding.default) { (data) in
            guard let model = data as? BaseListModel<NotificationModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func readNotification(parameters : [String : Any]?, completion: @escaping ((_ model: BaseModel<NotificationModel>?)->Void)) {
        let url = SERVER + "notification/read-unread-readall"
        RequestService.shared.requestWith(url, .post, parameters, nil, objectType: BaseModel<NotificationModel>.self, encoding: JSONEncoding.default) { (data) in
            guard let model = data as? BaseModel<NotificationModel> else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
}
