//
//  AuthenViewModel.swift
//  VietApp
//
//  Created by Admin on 6/11/22.
//


import Foundation

class AuthenViewModel: NSObject {
    
    func login(parameters : [String : Any]?, _ completeHandler:@escaping ((_ success: Bool,_ data: BaseModel<AuthResponseModel>?, _ message : String) ->())) {
        
        APIServices.shared.login(parameters: parameters) { (data) in
            if let user = data?.data, let access_token = user.token {
                var token = Token()
                token.user = user.user
                //token.token = access_token
                completeHandler(data?.result == true, data, data?.message ?? "Error")
            } else {
                completeHandler(data?.result == true, nil, data?.message ?? "Error")
            }
        }
    }
    
    func register(parameters : [String : Any]?,_ completeHandler:@escaping ((_ success: Bool,_ data: UserModel?, _ message : String) ->())) {
        APIServices.shared.register(parameters: parameters) { (data) in
            if let user = data?.data, let _token = user.token {
                var token = Token()
                token.user = user
                //token.token = _token
                completeHandler(data?.result == true, user, data?.message ?? "Error")
            } else {
                completeHandler(data?.result == true, nil, data?.message ?? "Error")
            }
        }
    }
    
    
    func getProfileCustomer(id: Int?, _ completeHandler:@escaping ((_ success: Bool,_ data: UserModel?, _ message : String) ->())) {
        APIServices.shared.getProfileCustomer(id: id) { (response) in
            if let data = response {
                completeHandler(true, data.data, response?.message ?? "Success")
            } else {
                completeHandler(false, nil, response?.message ?? "Error")
            }
        }
    }
    
    
    func forgotPassword(parameters : [String : Any]?, _ completeHandler:@escaping ((_ success: Bool,_ data: BaseResponse?, _ message : String) ->())) {
        APIServices.shared.forgotPassword(parameters: parameters) { (model) in
            if model?.result == true{
                completeHandler(true, model, model?.message ?? "Error")
            }else{
                completeHandler(false, nil, model?.message ?? "Error")
            }
        }
    }
    
    func resetPassword(parameters : [String : Any]?, _ completeHandler:@escaping ((_ success: Bool,_ data: BaseResponse?, _ message : String) ->())) {
        APIServices.shared.resetPassword(parameters: parameters) { (model) in
            if model?.result == true{
                completeHandler(true, model, model?.message ?? "Error")
            }else{
                completeHandler(false, nil, model?.message ?? "Error")
            }
        }
    }
    
    func getProfile(parameters : [String : Any]?, _ completeHandler:@escaping ((_ success: Bool,_ data: BaseModel<UserModel>?, _ message : String) ->())) {
        APIServices.shared.getProfile(parameters: parameters) { (model) in
            if model?.result == true{
                completeHandler(true, model, model?.message ?? "Error")
            }else{
                completeHandler(false, nil, model?.message ?? "Error")
            }
        }
    }
    
    func updateProfile(parameters: [String: Any]?, dataImages : [Dictionary<String, Any>]?, _ completion: @escaping ((_ success: Bool, _ data: BaseModel<UserModel>?, _ message: String) -> ())) {
        APIServices.shared.updateProfile(parameters: parameters, dataImages: dataImages) { (model) in
            if model?.result == true{
                var token = Token()
                token.user = model?.data
                completion(true, model, model?.message ?? "Error")
            }else{
                completion(false, nil, model?.message ?? "Error")
            }
        }
    }
    
    func logout(parameters: [String: Any]?, _ completion: @escaping ((_ success: Bool, _ data: BaseResponse?, _ message: String) -> ())) {
        APIServices.shared.logout(parameters: parameters) { (model) in
            if model?.result == true {
                completion(true, model, model?.message ?? kMsgSomethingWentWrong)
            } else {
                completion(false, nil, model?.message ?? kMsgSomethingWentWrong)
            }
        }
    }
    
    func listNotification(parameters : [String : Any]?, _ completeHandler:@escaping ((_ success: Bool,_ data: BaseListModel<NotificationModel>?, _ message : String) ->())) {
        APIServices.shared.listNotification(parameters: parameters) { (model) in
            if model?.result == true{
                completeHandler(true, model, model?.message ?? "Error")
            }else{
                completeHandler(false, nil, model?.message ?? "Error")
            }
        }
    }
    
    func readNotification(parameters : [String : Any]?, _ completeHandler:@escaping ((_ success: Bool,_ data: BaseModel<NotificationModel>?, _ message : String) ->())) {
        APIServices.shared.readNotification(parameters: parameters) { (model) in
            if model?.result == true{
                completeHandler(true, model, model?.message ?? "Error")
            }else{
                completeHandler(false, nil, model?.message ?? "Error")
            }
        }
    }
    

    
    
}
